#!/bin/bash
#Copyright 2023. TU Graz. Institute of Biomedical Imaging.
#Author: Moritz Blumenthal

set -eu
SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )
cd $SCRIPT_DIR

if [ -z "${RECODIR:-}" ]; then 
    RECODIR="$(readlink -e $SCRIPT_DIR/../)"
fi

SRC=$RECODIR/21_recos_rt/vol0082_vis1_slc16/

bart resize -c 10 120 $SRC/02_rtnlinv_rovir/img_rt tmp1
bart resize -c 10 120 $SRC/42_rovir_resnet_mad/img tmp2
bart resize -c 10 120 $SRC/44_rovir_resnet_mad_first/img tmp3

$SCRIPT_DIR/../01_scripts/52_create_movie.sh 00_template.svg view.sh $(basename $SCRIPT_DIR) tmp1 tmp2 tmp3
