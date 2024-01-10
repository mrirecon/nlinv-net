#!/bin/bash
#Copyright 2023. TU Graz. Institute of Biomedical Imaging.
#Author: Moritz Blumenthal

set -eu
SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )
cd $SCRIPT_DIR

if [ -z "${RECODIR:-}" ]; then 
    RECODIR="$(readlink -e $SCRIPT_DIR/../)"
fi

SRC=$RECODIR/21_recos_rt/vol0056_vis1_slc13/

CON="$($SCRIPT_DIR/../01_scripts/53_read_view.sh $SCRIPT_DIR/view.sh)"
CON_TIME="$($SCRIPT_DIR/../01_scripts/53_read_view.sh $SCRIPT_DIR/view_time.sh)"

bart copy $SRC/02_rtnlinv_rovir/img_rt tmp ; 		cfl2png -z3 -S65535 $CON	tmp img_rovir_nlinv
bart copy $SRC/21_rovir_resnet_mse/img tmp ; 		cfl2png -z3 -S65535 $CON	tmp img_rovir_mse
bart copy $SRC/22_rovir_resnet_mad/img tmp ; 		cfl2png -z3 -S65535 $CON	tmp img_rovir_mad
bart copy $SRC/23_rovir_resnet_mse_first/img tmp ; 	cfl2png -z3 -S65535 $CON	tmp img_rovir_mse_first
bart copy $SRC/24_rovir_resnet_mad_first/img tmp ; 	cfl2png -z3 -S65535 $CON	tmp img_rovir_mad_first
bart copy $SRC/02_rtnlinv_rovir/img_rt tmp ; 		cfl2png -z3 -S65535 $CON_TIME	tmp img_rovir_time_nlinv
bart copy $SRC/21_rovir_resnet_mse/img tmp ; 		cfl2png -z3 -S65535 $CON_TIME	tmp img_rovir_time_mse
bart copy $SRC/22_rovir_resnet_mad/img tmp ; 		cfl2png -z3 -S65535 $CON_TIME	tmp img_rovir_time_mad
bart copy $SRC/23_rovir_resnet_mse_first/img tmp ; 	cfl2png -z3 -S65535 $CON_TIME	tmp img_rovir_time_mse_first
bart copy $SRC/24_rovir_resnet_mad_first/img tmp ; 	cfl2png -z3 -S65535 $CON_TIME	tmp img_rovir_time_mad_first
bart copy $SRC/01_rtnlinv/img_rt tmp ; 			cfl2png -z3 -S65535 $CON	tmp img_nlinv
bart copy $SRC/11_resnet_mse/img tmp ; 			cfl2png -z3 -S65535 $CON	tmp img_mse
bart copy $SRC/12_resnet_mad/img tmp ; 			cfl2png -z3 -S65535 $CON	tmp img_mad
bart copy $SRC/13_resnet_mse_first/img tmp ; 		cfl2png -z3 -S65535 $CON	tmp img_mse_first
bart copy $SRC/14_resnet_mad_first/img tmp ; 		cfl2png -z3 -S65535 $CON	tmp img_mad_first
bart copy $SRC/01_rtnlinv/img_rt tmp ; 			cfl2png -z3 -S65535 $CON_TIME	tmp img_time_nlinv
bart copy $SRC/11_resnet_mse/img tmp ; 			cfl2png -z3 -S65535 $CON_TIME	tmp img_time_mse
bart copy $SRC/12_resnet_mad/img tmp ; 			cfl2png -z3 -S65535 $CON_TIME	tmp img_time_mad
bart copy $SRC/13_resnet_mse_first/img tmp ; 		cfl2png -z3 -S65535 $CON_TIME	tmp img_time_mse_first
bart copy $SRC/14_resnet_mad_first/img tmp ; 		cfl2png -z3 -S65535 $CON_TIME	tmp img_time_mad_first

inkscape --export-filename=$(basename $SCRIPT_DIR).eps 00_template.svg &>/dev/null
inkscape --export-filename=$(basename $SCRIPT_DIR).png 00_template.svg &>/dev/null
inkscape --export-filename=$(basename $SCRIPT_DIR).pdf 00_template.svg &>/dev/null
