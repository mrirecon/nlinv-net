#!/bin/bash
#Copyright 2023. TU Graz. Institute of Biomedical Imaging.
#Author: Moritz Blumenthal

export BART_COMPAT_VERSION="v0.9.00"

set -eu
SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )

SLICE=-1
LAM=""
ROVIR=""

CC=10
OS=1.5
FRAMES=""
RAW=0

while getopts "hC:O:l:VF:R" opt; do
	case $opt in
	O)
		OS=$OPTARG
	;;
	C)
		CC=$OPTARG
	;;
	R)
		RAW=1
	;;
	l)
		LAM=" -RW:7:$(bart bitmask 6):$OPTARG"
	;;
	F)
		FRAMES=" -F$OPTARG"
	;;
	V)
		ROVIR=" -V"
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

if [ $# -lt 2 ] ; then

        echo "$usage" >&2
        exit 1
fi

KSP=$(readlink -f "$1")
DAT=$(readlink -f "$2")
IMG=$(readlink -f "$3")

if [[ -f $IMG.hdr ]] ; then
	echo "$IMG exists. Skip."
	exit 0
fi

WORKDIR=`mktemp -d 2>/dev/null || mktemp -d -t 'mytmpdir'`
trap 'rm -rf "$WORKDIR"' EXIT
cd $WORKDIR

$SCRIPT_DIR/01_prep.sh $ROVIR $FRAMES -B1 -G9 -C$CC -M ${KSP}_sg1_idx_dia.txt $KSP $WORKDIR/

BR=$(($(bart show -d 1 ksp) / 2))
DIMS=$(LC_NUMERIC="en_US.UTF-8" printf "%.0f" $(echo "$OS*$BR" | bc))

bart scale $OS trj trj_og

DELAY=15.12e-3

if [[ 1 == $RAW ]] ; then
	bart nlinv -x$DIMS:$DIMS:1 -B $DAT/basis -S --cgiter=30 -M0.001 -g -i12 -p$WORKDIR/msk -ttrj_og -S -N $WORKDIR/ksp $IMG ${IMG}_col
	exit 0
fi

bart nlinv -x$DIMS:$DIMS:1 -B $DAT/basis -S --cgiter=30 -M0.001 -g -i12 -p$WORKDIR/msk -ttrj_og $WORKDIR/ksp coeff_nlinv col

if [[ "" == $LAM ]] ; then 

	bart resize -c 0 $BR 1 $BR coeff_nlinv $IMG
else 
	bart normalize $(bart bitmask 3) col colm
	bart pics -g -i500 -p $WORKDIR/msk -B $DAT/basis -S $LAM -e --gpu-gridding -ttrj_og $WORKDIR/ksp colm coeff_pics
	bart resize -c 0 $BR 1 $BR coeff_pics $IMG
fi

bart mobafit -g -B $DAT/basis -L --init 1:1:1 $DAT/TI $IMG pars
bart looklocker -t5.e-6 -D$DELAY pars ${IMG}_T1
