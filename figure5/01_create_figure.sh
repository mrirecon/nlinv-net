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

CON1="$($SCRIPT_DIR/../01_scripts/53_read_view.sh $SCRIPT_DIR/view1.sh)"
CON1_TIME="$($SCRIPT_DIR/../01_scripts/53_read_view.sh $SCRIPT_DIR/view1_time.sh)"
CON2="$($SCRIPT_DIR/../01_scripts/53_read_view.sh $SCRIPT_DIR/view2.sh)"
CON2_TIME="$($SCRIPT_DIR/../01_scripts/53_read_view.sh $SCRIPT_DIR/view2_time.sh)"

bart copy $SRC/02_rtnlinv_rovir/img_rt_fil 	tmp
cfl2png -z3 -S65535 $CON1	tmp img1_nlinv
cfl2png -z3 -S65535 $CON1_TIME	tmp img1_time_nlinv

bart copy $SRC/02_rtnlinv_rovir/img_rt_fil_nlmean tmp2

cfl2png -z3 -S65535 $CON1	tmp2 img1_fil_nlinv
cfl2png -z3 -S65535 $CON1_TIME	tmp2 img1_fil_time_nlinv

bart copy $SRC/44_rovir_resnet_mad_first/img_fil tmp

cfl2png -z3 -S65535 $CON1	tmp img1_mad_first
cfl2png -z3 -S65535 $CON1_TIME	tmp img1_time_mad_first

SRC=$RECODIR/21_recos_rt/vol0056_vis1_slc13/

bart copy $SRC/02_rtnlinv_rovir/img_rt_fil 	tmp
cfl2png -z3 -S65535 $CON2	tmp img2_nlinv
cfl2png -z3 -S65535 $CON2_TIME	tmp img2_time_nlinv

bart copy $SRC/02_rtnlinv_rovir/img_rt_fil_nlmean tmp2

cfl2png -z3 -S65535 $CON2	tmp2 img2_fil_nlinv
cfl2png -z3 -S65535 $CON2_TIME	tmp2 img2_fil_time_nlinv

bart copy $SRC/44_rovir_resnet_mad_first/img_fil tmp

cfl2png -z3 -S65535 $CON2	tmp img2_mad_first
cfl2png -z3 -S65535 $CON2_TIME	tmp img2_time_mad_first


inkscape --export-filename=$(basename $SCRIPT_DIR).eps 00_template.svg &>/dev/null
inkscape --export-filename=$(basename $SCRIPT_DIR).png 00_template.svg &>/dev/null
inkscape --export-filename=$(basename $SCRIPT_DIR).pdf 00_template.svg &>/dev/null