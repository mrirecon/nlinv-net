#!/bin/bash
#Copyright 2023. TU Graz. Institute of Biomedical Imaging.
#Author: Moritz Blumenthal

set -eu
SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )

SLICE=-1

CC=10
EPOCH=""
RAW=0
RSSNORM=" --rss-norm"
while getopts "hC:s:E:Rn" opt; do
	case $opt in
	C)
		CC=$OPTARG
	;;
	R)
		RAW=1
	;;
	s)
		SLICE=$OPTARG
	;;
	E)
		EPOCH="_$OPTARG"
	;;
	n)
		RSSNORM=""
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

SRC=$(readlink -f "$1")
WGH=$(readlink -f "$2")
IMG=$(readlink -f "$3")

if test -f "$IMG.hdr"; then
	echo "$IMG exists. EXIT"
	exit 0
fi

if [ ! -f "$WGH/weights$EPOCH.hdr" ] ; then
	echo "weights$EPOCH does not exist. EXIT"
	exit 0
fi

WORKDIR=`mktemp -d 2>/dev/null || mktemp -d -t 'mytmpdir'`
trap 'rm -rf "$WORKDIR"' EXIT
cd $WORKDIR

ROVIR=""

source $WGH/config.sh

$SCRIPT_DIR/01_prep.sh $ROVIR -B$SPOKES -s$SLICE -C$CC $SRC ./

BR=$(($(bart show -d 1 ksp) / 2))

bart scale $OS trj trj_scl
DIMS=$(LC_NUMERIC="en_US.UTF-8" printf "%.0f" $(echo "$OS*$BR" | bc))

bart transpose 13 15 ksp ksp2
bart transpose 13 15 trj_scl trj2

if [[ 1 == $RAW ]] ; then

	time bart nlinvnet --apply $NETWORK -g --sens-os=$COS -x${DIMS}:${DIMS}:1 --trajectory=trj2 ksp2 $WGH/weights$EPOCH imgt colt
	bart transpose 13 15 imgt $IMG
	bart transpose 13 15 colt ${IMG}_col
else
	time bart nlinvnet --apply $RSSNORM $NETWORK -g --sens-os=$COS -x${DIMS}:${DIMS}:1 --trajectory=trj2 ksp2 $WGH/weights$EPOCH imgt colt
	bart transpose 13 15 imgt img
	bart resize -c 0 $BR 1 $BR img $IMG
fi

$SCRIPT_DIR/03_median_filter.sh $((65/SPOKES)) $IMG ${IMG}_fil

