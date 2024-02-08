#!/bin/bash
#Copyright 2023. TU Graz. Institute of Biomedical Imaging.
#Author: Moritz Blumenthal

set -eu
SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )

helpstr=$(cat <<- EOF
Creation of k-space and trajectory from dat file

-h help
EOF
)

usage="Usage: $0 <meas.dat> <outdir>"

COILS=0
ROVir=0
ROVir_ORDER=0
ROVIR_POS=1.
ROVIR_NEG=1.25
SLICE=-1
BINNING=-1
MSK=""

GA=9
TURNS=5

while getopts "B:C:s:M:VP:N:G:T:" opt; do
	case $opt in
	C)
		COILS=$OPTARG
	;;
	B)
		BINNING=$OPTARG
	;;
	s)
		SLICE=$OPTARG
	;;
	M)
		MSK=$(readlink -f "$OPTARG")
	;;
	G)
		TURNS=-1
		GA=$OPTARG
	;;
	T)
		TRUNS=$OPTARG
	;;
	P)
		ROVIR_POS=$OPTARG
		ROVir_ORDER=1
	;;
	N)
		ROVIR_NEG=$OPTARG
		ROVir_ORDER=1
	;;
	V)
		ROVir=1
	;;
    esac
done

shift $((OPTIND - 1))

if [ $# -lt 2 ] ; then

	echo "$usage" >&2
	exit 1
fi

SRC=$(readlink -f "$1")
OUT_DIR=$(readlink -f "$2")
mkdir -p $OUT_DIR

READ=$(bart show -d0 $SRC)
PHS1=$(bart show -d1 $SRC)
COIL=$(bart show -d3 $SRC)
TIME=$(bart show -d10 $SRC)
SLCS=$(bart show -d13 $SRC)

if [[ $BINNING -eq -1 ]] ; then
	BINNING=$PHS1
fi

WORKDIR=$(mktemp -d 2>/dev/null || mktemp -d -t 'mytmpdir')
trap 'rm -rf "$WORKDIR"' EXIT
cd "$WORKDIR" || exit

if [[ $SLICE == -1 ]] ; then
	
	bart reshape "$(bart bitmask 0 1 2)" 1 "$READ" "$PHS1" $SRC ksp
else
	bart slice 13 $SLICE $SRC tmp
	bart reshape "$(bart bitmask 0 1 2)" 1 "$READ" "$PHS1" tmp ksp
	SLCS=1
fi

bart reshape "$(bart bitmask 2 10)" $(( $(bart show -d 2 ksp) * $(bart show -d 10 ksp) )) 1 ksp kspf

SPOKES=$(bart show -d 2 kspf)

if [[ -1 -lt $TURNS ]] ; then
	topts=(-r -D -l -x"$READ" -y"$PHS1" -t"$TURNS")
else
	if [[ -1 -lt $GA ]] ; then 
		topts=(-r -D -l -G -s$GA -x"$READ" -y"$PHS1" -t"$TIME")
	else
		echo "Either select Golden angle (-G) or Turns (-T)"
		exit 1
	fi
fi

#Trajectory for gradient delay corrections
bart traj "${topts[@]}" trj
bart reshape "$(bart bitmask 2 10)" $(( $(bart show -d 2 trj) * $(bart show -d 10 trj) )) 1 trj trjf

#Repeat trajectory to match ksp dims
if [[ $(bart show -d 2 trjf) -ne $SPOKES ]] ; then
	
	bart repmat 3 $((1 + (SPOKES / $(bart show -d 2 trjf)))) trjf tmp
	bart reshape $(bart bitmask 2 3) $(($(bart show -d 2 tmp) * $(bart show -d 3 tmp))) 1 tmp tmp2
	bart extract 2 0 $SPOKES tmp2 trjf
fi

bart extract 2 $((SPOKES - (5*PHS1) )) $SPOKES kspf ksp_cal
bart extract 2 $((SPOKES - (5*PHS1) )) $SPOKES trjf trj_cal

bart -p$(bart bitmask 13) -r ksp_cal estdelay -r2. -R trj_cal ksp_cal delay



#Generate corrected trajectory
bart -p$(bart bitmask 13) -r kspf traj "${topts[@]}" -Vdelay -O trj
bart reshape "$(bart bitmask 2 10)" $(( $(bart show -d 2 trj) * $(bart show -d 10 trj) )) 1 trj trjf

#Repeat trajectory to match ksp dims
if [[ $(bart show -d 2 trjf) -ne $SPOKES ]] ; then
	
	bart repmat 3 $((1 + (SPOKES / $(bart show -d 2 trjf)))) trjf tmp
	bart reshape $(bart bitmask 2 3) $(($(bart show -d 2 tmp) * $(bart show -d 3 tmp))) 1 tmp tmp2
	bart extract 2 0 $SPOKES tmp2 trjf
fi


#coil compression
if [ $COILS -gt 0 ]; then

	GRD=80

	if [ $ROVir -gt 0 ]; then

		bart extract 2 $((SPOKES - (5*PHS1) )) $SPOKES trjf trj_cal
		bart -p$(bart bitmask 13) -r ksp_cal nufftbase $GRD:$GRD:1 trj_cal p

		#OMP_NUM_THREADS=1 for better reproducibility as non-deterministic nuFFT may lead to slightly different
		#coil compression matrices such that the difference propagates through the reconstructions
		OMP_NUM_THREADS=1 bart -p$(bart bitmask 13) -r ksp_cal nufft -p p -i -x$GRD:$GRD:1 trj_cal ksp_cal cim

		bart resize -c 0 $((GRD/2)) 1 $((GRD/2)) cim tmp
		bart resize -c 0 $GRD 1 $GRD tmp cen

		bart resize -c 0 $((GRD/8*5)) 1 $((GRD/8*5)) cim tmp
		bart resize -c 0 $GRD 1 $GRD tmp crop
		bart saxpy -- -1 crop cim out

		bart -p$(bart bitmask 13) -r ksp_cal nufft -pp trj_cal cen kcen
		bart -p$(bart bitmask 13) -r ksp_cal nufft -pp trj_cal out kout

		bart -l$(bart bitmask 13) -r ksp_cal rovir kcen kout compress
	else
		bart -p$(bart bitmask 13) -r ksp_cal cc -A -M ksp_cal compress
	fi

	bart -p$(bart bitmask 13) -r ksp_cal ccapply -p$COILS kspf compress tmp
	bart copy tmp kspf

	if [ $ROVir_ORDER -gt 0 ]; then

		bart -p$(bart bitmask 13) -r ksp_cal ccapply -p$COILS ksp_cal compress ksp_cal2

		bart extract 2 $((SPOKES - (5*PHS1) )) $SPOKES trjf trj_cal
		bart -p$(bart bitmask 13) -r ksp_cal nufftbase $GRD:$GRD:1 trj_cal p

		ROVIR_POS=$(LC_NUMERIC="en_US.UTF-8" printf "%.0f" $(echo "$ROVIR_POS*$GRD*0.5" | bc))
		ROVIR_NEG=$(LC_NUMERIC="en_US.UTF-8" printf "%.0f" $(echo "$ROVIR_NEG*$GRD*0.5" | bc))

		#OMP_NUM_THREADS=1 for better reproducibility as non-deterministic nuFFT may lead to slightly different
		#coil compression matrices such that the difference propagates through the reconstructions
		OMP_NUM_THREADS=1 bart -p$(bart bitmask 13) -r ksp_cal nufft -p p -i -x$GRD:$GRD:1 trj_cal ksp_cal2 cim

		bart resize -c 0 $ROVIR_POS 1 $ROVIR_POS cim tmp
		bart resize -c 0 $GRD 1 $GRD tmp cen

		bart resize -c 0 $ROVIR_NEG 1 $ROVIR_NEG cim tmp
		bart resize -c 0 $GRD 1 $GRD tmp crop
		bart saxpy -- -1 crop cim out

		bart -p$(bart bitmask 13) -r ksp_cal nufft -pp trj_cal cen kcen
		bart -p$(bart bitmask 13) -r ksp_cal nufft -pp trj_cal out kout

		bart -l$(bart bitmask 13) -r ksp_cal rovir kcen kout order

		bart -p$(bart bitmask 13) -r ksp_cal ccapply kspf order tmp
		bart copy tmp kspf
	fi	
fi

SPOKES=$((SPOKES/BINNING))
SPOKES=$((SPOKES*BINNING))

bart extract 2 0 $SPOKES trjf trjt
bart extract 2 0 $SPOKES kspf kspt

SPOKES=$((SPOKES/BINNING))

bart scale 0.5 trjt trjo

if [[ ! -z "$MSK" ]] ; then

	FRM=""
	for i in $(seq 0 $(($(bart show -d 10 ksp) - 1))) ; do

		if grep -q -x "$i" $MSK ; then
			FRM=$FRM" 1"
		else 
			FRM=$FRM" 0"
		fi
	done

	bart vec $FRM vec
	bart repmat 1 $(bart show -d2 ksp) vec vec2
	bart transpose 0 1 vec2 vec
	bart flatten vec vec2
	bart resize 0 $((SPOKES*BINNING)) vec2 vec
	bart reshape $(bart bitmask 0 2 5) 1 $BINNING $SPOKES vec vec2
	bart repmat 1 $(bart show -d1 ksp) vec2 $OUT_DIR/msk

	bart reshape $(bart bitmask 2 5) $BINNING $SPOKES trjo  $OUT_DIR/trj
	bart reshape $(bart bitmask 2 5) $BINNING $SPOKES kspt  $OUT_DIR/ksp
else

	bart reshape $(bart bitmask 2 10) $BINNING $SPOKES trjo  $OUT_DIR/trj
	bart reshape $(bart bitmask 2 10) $BINNING $SPOKES kspt  $OUT_DIR/ksp
fi

