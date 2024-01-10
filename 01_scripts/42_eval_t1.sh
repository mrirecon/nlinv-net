#!/bin/bash
#Copyright 2023. TU Graz. Institute of Biomedical Imaging.
#Author: Moritz Blumenthal

set -eu
SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )

while getopts "h" opt; do
	case $opt in
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
DATASET=22_recos_t1

if [ -z "${RECODIR:-}" ]; then 
    RECODIR="$SCRIPT_DIR/../"
fi


mkdir -p $RECODIR/$DATASET/
BDIR=$RECODIR/$DATASET/00_prep
if [[ ! -d $BDIR ]] ; then
	mkdir -p $BDIR
	$SCRIPT_DIR/02_create_basis.sh 0.00267 1530 $BDIR/
fi


ODIR=$RECODIR/$DATASET/$(basename $RAW .dat)/
mkdir -p $ODIR

mkdir -p $ODIR/01_nlinv/
$SCRIPT_DIR/12_reco_t1.sh -O1.5 $RAW $BDIR/ $ODIR/01_nlinv/img

mkdir -p $ODIR/02_nlinv_rovir/
$SCRIPT_DIR/12_reco_t1.sh -V -O1.5 $RAW $BDIR/ $ODIR/02_nlinv_rovir/img

mkdir -p $ODIR/03_pics_l0.00{1,2,3,4,5,6,7,8,9}/
$SCRIPT_DIR/12_reco_t1.sh -O1.5 -l0.001 $RAW $BDIR/ $ODIR/03_pics_l0.001/img
$SCRIPT_DIR/12_reco_t1.sh -O1.5 -l0.002 $RAW $BDIR/ $ODIR/03_pics_l0.002/img
$SCRIPT_DIR/12_reco_t1.sh -O1.5 -l0.003 $RAW $BDIR/ $ODIR/03_pics_l0.003/img
#$SCRIPT_DIR/12_reco_t1.sh -O1.5 -l0.004 $RAW $BDIR/ $ODIR/03_pics_l0.004/img
#$SCRIPT_DIR/12_reco_t1.sh -O1.5 -l0.005 $RAW $BDIR/ $ODIR/03_pics_l0.005/img
#$SCRIPT_DIR/12_reco_t1.sh -O1.5 -l0.006 $RAW $BDIR/ $ODIR/03_pics_l0.006/img
#$SCRIPT_DIR/12_reco_t1.sh -O1.5 -l0.007 $RAW $BDIR/ $ODIR/03_pics_l0.007/img
$SCRIPT_DIR/12_reco_t1.sh -O1.5 -l0.008 $RAW $BDIR/ $ODIR/03_pics_l0.008/img
#$SCRIPT_DIR/12_reco_t1.sh -O1.5 -l0.009 $RAW $BDIR/ $ODIR/03_pics_l0.009/img

mkdir -p $ODIR/04_pics_rovir_l0.00{1,2,3,4,5,6,7,8,9}/
$SCRIPT_DIR/12_reco_t1.sh -V -O1.5 -l0.001 $RAW $BDIR/ $ODIR/04_pics_rovir_l0.001/img
$SCRIPT_DIR/12_reco_t1.sh -V -O1.5 -l0.002 $RAW $BDIR/ $ODIR/04_pics_rovir_l0.002/img
$SCRIPT_DIR/12_reco_t1.sh -V -O1.5 -l0.003 $RAW $BDIR/ $ODIR/04_pics_rovir_l0.003/img
#$SCRIPT_DIR/12_reco_t1.sh -V -O1.5 -l0.004 $RAW $BDIR/ $ODIR/04_pics_rovir_l0.004/img
#$SCRIPT_DIR/12_reco_t1.sh -V -O1.5 -l0.005 $RAW $BDIR/ $ODIR/04_pics_rovir_l0.005/img
#$SCRIPT_DIR/12_reco_t1.sh -V -O1.5 -l0.006 $RAW $BDIR/ $ODIR/04_pics_rovir_l0.006/img
#$SCRIPT_DIR/12_reco_t1.sh -V -O1.5 -l0.007 $RAW $BDIR/ $ODIR/04_pics_rovir_l0.007/img
$SCRIPT_DIR/12_reco_t1.sh -V -O1.5 -l0.008 $RAW $BDIR/ $ODIR/04_pics_rovir_l0.008/img
#$SCRIPT_DIR/12_reco_t1.sh -V -O1.5 -l0.009 $RAW $BDIR/ $ODIR/04_pics_rovir_l0.009/img

if [ $# -lt 2 ] ; then
        exit 0
fi

NETWORK=$(readlink -f "$2")
NET=$(basename $NETWORK)

mkdir -p $ODIR/$NET
$SCRIPT_DIR/13_reco_nlinvnet_t1.sh $RAW $NETWORK $ODIR/$NET/img

