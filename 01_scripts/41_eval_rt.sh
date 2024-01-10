#!/bin/bash
#Copyright 2023. TU Graz. Institute of Biomedical Imaging.
#Author: Moritz Blumenthal

set -eu
SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )

SLICE=""
SLICE_POST=""
RSS_POST="_rss"
RSS=""

while getopts "hs:N" opt; do
	case $opt in
	s)
		SLICE=-s$OPTARG
		SLICE_POST="_slc$OPTARG"
	;;
	N)
		RSS=-n
		RSS_POST=""
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

if [ $# -lt 1 ] ; then

        echo "$usage" >&2
        exit 1
fi

RAW=$(readlink -f "$1")
DATASET=21_recos_rt

if [ -z "${RECODIR:-}" ]; then 
    RECODIR="$SCRIPT_DIR/../"
fi

DIR=$RECODIR/$DATASET/$(basename $RAW)$RSS_POST$SLICE_POST/

mkdir -p $DIR/01_rtnlinv/
$SCRIPT_DIR/10_reco_rt.sh $RSS $SLICE -S13 $RAW $DIR/01_rtnlinv/img_rt

mkdir -p $DIR/02_rtnlinv_rovir/
$SCRIPT_DIR/10_reco_rt.sh $RSS $SLICE -S13 -V $RAW $DIR/02_rtnlinv_rovir/img_rt

if [ $# -lt 2 ] ; then
        exit 0
fi

NETWORK=$(readlink -f "$2")
NET=$(basename $NETWORK)

mkdir -p $DIR/$NET

$SCRIPT_DIR/11_reco_nlinvnet_rt.sh $RSS $SLICE $RAW $NETWORK $DIR/$NET/img

