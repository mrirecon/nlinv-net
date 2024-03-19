#!/bin/bash
#Copyright 2023. TU Graz. Institute of Biomedical Imaging.
#Author: Moritz Blumenthal

set -eu
SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )
cd $SCRIPT_DIR

if [ -z "${RECODIR:-}" ]; then 
    RECODIR="$(readlink -e $SCRIPT_DIR/../)"
fi

SRC=$RECODIR/21_recos_rt/vol0056_vis1_slc13_raw/

bart slice 3 0 $SRC/02_rtnlinv_rovir/img_rt  ttmp1
bart slice 3 0 $SRC/02_rtnlinv_rovir/img_rt_col ttmp2
bart slice 3 1 $SRC/02_rtnlinv_rovir/img_rt_col ttmp3
bart slice 3 9 $SRC/02_rtnlinv_rovir/img_rt_col ttmp4

bart slice 3 0 $SRC/44_rovir_resnet_mad_first/img ttmp5
bart slice 3 0 $SRC/44_rovir_resnet_mad_first/img_col ttmp6
bart slice 3 1 $SRC/44_rovir_resnet_mad_first/img_col ttmp7
bart slice 3 9 $SRC/44_rovir_resnet_mad_first/img_col ttmp8

for d in tmp1 tmp2 tmp3 tmp4 tmp5 tmp6 tmp7 tmp8; do 
	bart resize -c 10 121 t$d $d
done

$SCRIPT_DIR/../01_scripts/52_create_movie.sh 00_template.svg view.sh $(basename $SCRIPT_DIR) tmp1 tmp2 tmp3 tmp4 tmp5 tmp6 tmp7 tmp8
