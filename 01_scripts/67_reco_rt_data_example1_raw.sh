#!/bin/bash
#Copyright 2024. TU Graz. Institute of Biomedical Imaging.
#Author: Moritz Blumenthal

set -eu
SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )

cd $SCRIPT_DIR/..

RAWDIR=${RAWDIR:-$SCRIPT_DIR/../00_data/10_raw_data}
RAW=$RAWDIR/rt_sa/vol0082_vis1

if [ -z "${RECODIR:-}" ]; then 
    RECODIR="$SCRIPT_DIR/../"
fi

DIR=$RECODIR/21_recos_rt/$(basename $RAW)_slc16_raw/

mkdir -p $DIR/02_rtnlinv_rovir/
$SCRIPT_DIR/10_reco_rt.sh -R -s16 -S13 -V $RAW $DIR/02_rtnlinv_rovir/img_rt

NETWORK=$SCRIPT_DIR/../11_networks_rt/44_rovir_resnet_mad_first/
NET=$(basename $NETWORK)

mkdir -p $DIR/$NET
$SCRIPT_DIR/11_reco_nlinvnet_rt.sh -R -s16 $RAW $NETWORK $DIR/$NET/img
