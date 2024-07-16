#!/bin/bash
#Copyright 2023. TU Graz. Institute of Biomedical Imaging.
#Author: Moritz Blumenthal

export BART_COMPAT_VERSION="v0.9.00"

set -eu
SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )

SLICE=-1

CC=10
ITER=6
COS=1.25

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

export BART_DEBUG_LEVEL=4

time bart -l$(bart bitmask 13) -r ksp nlinv --cgiter=30 -N -S --real-time -g --sens-os=$COS -i$ITER -x${DIMS}:${DIMS}:1 -ttrj_scl ksp img col
bart avg $(bart bitmask 10) col ${IMG}_col

bart -l$(bart bitmask 13) -r ksp pics -g -i300 -S -e -R L:7:7:.001 -t trj_scl ksp ${IMG}_col img
bart resize -c 0 $BR 1 $BR img ${IMG}_001

bart -l$(bart bitmask 13) -r ksp pics -g -i300 -S -e -R L:7:7:.005 -t trj_scl ksp ${IMG}_col img
bart resize -c 0 $BR 1 $BR img ${IMG}_005

bart -l$(bart bitmask 13) -r ksp pics -g -i300 -S -e -R L:7:7:.010 -t trj_scl ksp ${IMG}_col img
bart resize -c 0 $BR 1 $BR img ${IMG}_010





