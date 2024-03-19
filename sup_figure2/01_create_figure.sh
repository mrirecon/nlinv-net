#!/bin/bash
#Copyright 2023. TU Graz. Institute of Biomedical Imaging.
#Author: Moritz Blumenthal

set -eu
SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )
cd $SCRIPT_DIR

if [ -z "${RECODIR:-}" ]; then 
    RECODIR="$(readlink -e $SCRIPT_DIR/../)"
fi

SRC=$RECODIR/21_recos_rt/vol0082_vis1_slc16_raw/

CON="$($SCRIPT_DIR/../01_scripts/53_read_view.sh $SCRIPT_DIR/view.sh)"
CON_TIME="$($SCRIPT_DIR/../01_scripts/53_read_view.sh $SCRIPT_DIR/view_time.sh)"

bart resize -c 10 121 $SRC/02_rtnlinv_rovir/img_rt tmp1 ; 		cfl2png -z3 -S65535 $CON	tmp1 img_rovir_nlinv
bart resize -c 10 121 $SRC/02_rtnlinv_rovir/img_rt_col tmp2 ; 		cfl2png -z3 -S65527 $CON	tmp2 col_rovir_nlinv
bart fmac tmp1 tmp2 tmp3 ; 						cfl2png -z3 -S65527 $CON	tmp3 cim_rovir_nlinv

bart resize -c 10 121 $SRC/02_rtnlinv_rovir/img_rt tmp1 ; 		cfl2png -z3 -S65535 $CON_TIME	tmp1 img_tim_rovir_nlinv
bart resize -c 10 121 $SRC/02_rtnlinv_rovir/img_rt_col tmp2 ; 		cfl2png -z3 -S65527 $CON_TIME	tmp2 col_tim_rovir_nlinv
bart fmac tmp1 tmp2 tmp3 ; 						cfl2png -z3 -S65527 $CON_TIME	tmp3 cim_tim_rovir_nlinv

bart resize -c 10 121 $SRC/44_rovir_resnet_mad_first/img tmp1 ; 	cfl2png -z3 -S65535 $CON	tmp1 img_rovir_nlinvnet
bart resize -c 10 121 $SRC/44_rovir_resnet_mad_first/img_col tmp2 ; 	cfl2png -z3 -S65527 $CON	tmp2 col_rovir_nlinvnet
bart fmac tmp1 tmp2 tmp3 ; 						cfl2png -z3 -S65527 $CON	tmp3 cim_rovir_nlinvnet

bart resize -c 10 121 $SRC/44_rovir_resnet_mad_first/img tmp1 ; 	cfl2png -z3 -S65535 $CON_TIME	tmp1 img_tim_rovir_nlinvnet
bart resize -c 10 121 $SRC/44_rovir_resnet_mad_first/img_col tmp2 ; 	cfl2png -z3 -S65527 $CON_TIME	tmp2 col_tim_rovir_nlinvnet
bart fmac tmp1 tmp2 tmp3 ; 						cfl2png -z3 -S65527 $CON_TIME	tmp3 cim_tim_rovir_nlinvnet

inkscape --export-filename=$(basename $SCRIPT_DIR).eps 00_template.svg &>/dev/null
inkscape --export-filename=$(basename $SCRIPT_DIR).png 00_template.svg &>/dev/null
inkscape --export-filename=$(basename $SCRIPT_DIR).pdf 00_template.svg &>/dev/null
