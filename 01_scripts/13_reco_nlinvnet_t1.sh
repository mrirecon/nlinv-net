#!/bin/bash
#Copyright 2023. TU Graz. Institute of Biomedical Imaging.
#Author: Moritz Blumenthal

set -eu
SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )

SLICE=-1
CC=10

EPOCH=""
RAW=""
FRAMES=""

while getopts "hE:RVF:" opt; do
	case $opt in
	E)
		EPOCH="_$OPTARG"
	;;
	R)
		RAW=1
	;;
	F)
		FRAMES=" -F$OPTARG"
	;;
	h)
		echo "No help available!"
		exit 0
	;;
	\?)
		exit 1
	;;
	esac
done

shift $((OPTIND - 1))

if [ $# -lt 3 ] ; then

        echo "$usage" >&2
        exit 1
fi

KSP=$(readlink -f "$1")
WGH=$(readlink -f "$2")
IMG=$(readlink -f "$3")

if [[ -f "$IMG.hdr" ]] ; then
	echo "$IMG exists. Skip."
	exit 0
fi

if [[ ! -f $WGH/weights$EPOCH.hdr ]] ; then
	echo "$WGH/weights$EPOCH does not exist. Skip."
	exit 0
fi

WORKDIR=`mktemp -d 2>/dev/null || mktemp -d -t 'mytmpdir'`
trap 'rm -rf "$WORKDIR"' EXIT
echo $WORKDIR
cd $WORKDIR

ROVIR=""
source $WGH/config.sh

$SCRIPT_DIR/01_prep.sh $ROVIR $FRAMES -G9 -B1 -C$CC -M ${KSP}_sg1_idx_dia.txt $KSP ./

BR=$(($(bart show -d 1 ksp) / 2))
DIMS=$(LC_NUMERIC="en_US.UTF-8" printf "%.0f" $(echo "$OS*$BR" | bc))

bart scale $OS trj trj_og

if [[ 1 -eq $RAW ]] ; then

	bart nlinvnet --apply -L$(bart bitmask 11 13 15) $NETWORK -g --sens-os=$COS -x${DIMS}:${DIMS}:1 --trajectory=trj_og --pattern=msk --basis=$WGH/basis ksp $WGH/weights$EPOCH $IMG ${IMG}_col
	bart copy trj_og ${IMG}_trj
	bart copy msk ${IMG}_msk
	bart copy $WGH/basis ${IMG}_bas
	bart copy ksp ${IMG}_ksp

	exit 0
fi

bart nlinvnet --apply --rss-norm -L$(bart bitmask 11 13 15) $NETWORK -g --sens-os=$COS -x${DIMS}:${DIMS}:1 --trajectory=trj_og --pattern=msk --basis=$WGH/basis ksp $WGH/weights$EPOCH img
bart resize -c 0 $BR 1 $BR img $IMG

DELAY=15.12e-3

bart mobafit -g -B $WGH/basis -L --init 1:1:1 $WGH/TI $IMG pars
bart looklocker -t5.e-6 -D$DELAY pars ${IMG}_T1

