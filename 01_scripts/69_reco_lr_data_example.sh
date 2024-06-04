#!/bin/bash
#Copyright 2024. TU Graz. Institute of Biomedical Imaging.
#Author: Moritz Blumenthal

set -eu
SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )

cd $SCRIPT_DIR/..

RAWDIR=${RAWDIR:-$SCRIPT_DIR/../00_data/10_raw_data}

if [ -z "${RECODIR:-}" ]; then 
    RECODIR="$SCRIPT_DIR/../"
fi

RAW=$RAWDIR/rt_sa/vol0056_vis1
DIR=$RECODIR/21_recos_rt/$(basename $RAW)_slc13/
mkdir -p $DIR/04_pics_llr_rovir/
$SCRIPT_DIR/14_reco_lr.sh -R -s13 -S13 -V $RAW $DIR/04_pics_llr_rovir/img_llr

RAW=$RAWDIR/rt_sa/vol0082_vis1
DIR=$RECODIR/21_recos_rt/$(basename $RAW)_slc16/
mkdir -p $DIR/04_pics_llr_rovir/
$SCRIPT_DIR/14_reco_lr.sh -R -s16 -S13 -V $RAW $DIR/04_pics_llr_rovir/img_llr
