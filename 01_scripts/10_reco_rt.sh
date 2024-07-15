#!/bin/bash
#Copyright 2023. TU Graz. Institute of Biomedical Imaging.
#Author: Moritz Blumenthal

set -eu
SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )

SLICE=-1

CC=10
ITER=6
COS=2

OS=1.5
BR=160
SPOKES=13

RAW=0
ROVIR=""
RSSNORM=""

while getopts "hC:O:s:S:i:RVN:P:n" opt; do
	case $opt in
	O)
		OS=$OPTARG
	;;
	C)
		CC=$OPTARG
	;;
	s)
		SLICE=$OPTARG
	;;
	S)
		SPOKES=$OPTARG
	;;
	i)
		ITER=$OPTARG
	;;
	R)
		RAW=1
	;;
	V)
		ROVIR=$ROVIR" -V"
	;;
	P)
		ROVIR=$ROVIR" -P$OPTARG"
	;;
	N)
		ROVIR=$ROVIR" -N$OPTARG"
	;;
	n)
		RSSNORM="-N "
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

SRC=$(readlink -f "$1")
IMG=$(readlink -f "$2")

if test -f "$IMG.hdr"; then
	echo "$IMG exists. EXIT"
	exit 0
fi

WORKDIR=`mktemp -d 2>/dev/null || mktemp -d -t 'mytmpdir'`
trap 'rm -rf "$WORKDIR"' EXIT
cd $WORKDIR

$SCRIPT_DIR/01_prep.sh -B$SPOKES -s$SLICE -C$CC $ROVIR $SRC ./

bart scale $OS trj trj_scl
DIMS=$(LC_NUMERIC="en_US.UTF-8" printf "%.0f" $(echo "$OS*$BR" | bc))

if [[ 1 == $RAW ]] ; then
	time bart -l$(bart bitmask 13) -r ksp nlinv --cgiter=30 -N -S --real-time -g --sens-os=$COS -i$ITER -x${DIMS}:${DIMS}:1 -ttrj_scl ksp $IMG ${IMG}_col
else
	time bart -l$(bart bitmask 13) -r ksp nlinv --cgiter=30 $RSSNORM -S --real-time -g --sens-os=$COS -i$ITER -x${DIMS}:${DIMS}:1 -ttrj_scl ksp img col
	bart resize -c 0 $BR 1 $BR img $IMG
fi

$SCRIPT_DIR/03_median_filter.sh $((65/SPOKES)) $IMG ${IMG}_fil

bart -p $(bart bitmask 10) -r ${IMG}_fil nlmeans -H 0.00005 -a0.1 3 ${IMG}_fil ${IMG}_fil_nlmean
