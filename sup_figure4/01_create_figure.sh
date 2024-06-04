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
CON="$($SCRIPT_DIR/../01_scripts/53_read_view.sh $SCRIPT_DIR/view1.sh)"
CON_TIME="$($SCRIPT_DIR/../01_scripts/53_read_view.sh $SCRIPT_DIR/view_time1.sh)"

bart copy $SRC/02_rtnlinv_rovir/img_rt tmp ; 			cfl2png -z3 -S65535 $CON	tmp img1_rovir_nlinv
bart copy $SRC/04_pics_llr_rovir/img_llr_005 tmp ; 		cfl2png -z3 -S65535 $CON	tmp img1_rovir_llr
bart copy $SRC/51_rovir_resnet_mad_first_1frame/img tmp ; 	cfl2png -z3 -S65535 $CON	tmp img1_rovir_mad_first1
bart copy $SRC/44_rovir_resnet_mad_first/img tmp ; 		cfl2png -z3 -S65535 $CON	tmp img1_rovir_mad_first3
bart copy $SRC/52_rovir_resnet_mad_first_5frames/img tmp ; 	cfl2png -z3 -S65535 $CON	tmp img1_rovir_mad_first5

bart copy $SRC/02_rtnlinv_rovir/img_rt tmp ; 			cfl2png -z3 -S65535 $CON_TIME	tmp img1_time_rovir_nlinv
bart copy $SRC/04_pics_llr_rovir/img_llr_005 tmp ; 		cfl2png -z3 -S65535 $CON_TIME	tmp img1_time_rovir_llr
bart copy $SRC/51_rovir_resnet_mad_first_1frame/img tmp ; 	cfl2png -z3 -S65535 $CON_TIME	tmp img1_time_rovir_mad_first1
bart copy $SRC/44_rovir_resnet_mad_first/img tmp ; 		cfl2png -z3 -S65535 $CON_TIME	tmp img1_time_rovir_mad_first3
bart copy $SRC/52_rovir_resnet_mad_first_5frames/img tmp ; 	cfl2png -z3 -S65535 $CON_TIME	tmp img1_time_rovir_mad_first5


SRC=$RECODIR/21_recos_rt/vol0056_vis1_slc13/
CON="$($SCRIPT_DIR/../01_scripts/53_read_view.sh $SCRIPT_DIR/view2.sh)"
CON_TIME="$($SCRIPT_DIR/../01_scripts/53_read_view.sh $SCRIPT_DIR/view_time2.sh)"

bart copy $SRC/02_rtnlinv_rovir/img_rt tmp ; 			cfl2png -z3 -S65535 $CON	tmp img2_rovir_nlinv
bart copy $SRC/04_pics_llr_rovir/img_llr_005 tmp ; 		cfl2png -z3 -S65535 $CON	tmp img2_rovir_llr
bart copy $SRC/51_rovir_resnet_mad_first_1frame/img tmp ; 	cfl2png -z3 -S65535 $CON	tmp img2_rovir_mad_first1
bart copy $SRC/44_rovir_resnet_mad_first/img tmp ; 		cfl2png -z3 -S65535 $CON	tmp img2_rovir_mad_first3
bart copy $SRC/52_rovir_resnet_mad_first_5frames/img tmp ; 	cfl2png -z3 -S65535 $CON	tmp img2_rovir_mad_first5

bart copy $SRC/02_rtnlinv_rovir/img_rt tmp ; 			cfl2png -z3 -S65535 $CON_TIME	tmp img2_time_rovir_nlinv
bart copy $SRC/04_pics_llr_rovir/img_llr_005 tmp ; 		cfl2png -z3 -S65535 $CON_TIME	tmp img2_time_rovir_llr
bart copy $SRC/51_rovir_resnet_mad_first_1frame/img tmp ; 	cfl2png -z3 -S65535 $CON_TIME	tmp img2_time_rovir_mad_first1
bart copy $SRC/44_rovir_resnet_mad_first/img tmp ; 		cfl2png -z3 -S65535 $CON_TIME	tmp img2_time_rovir_mad_first3
bart copy $SRC/52_rovir_resnet_mad_first_5frames/img tmp ; 	cfl2png -z3 -S65535 $CON_TIME	tmp img2_time_rovir_mad_first5



inkscape --export-filename=$(basename $SCRIPT_DIR).eps 00_template.svg &>/dev/null
inkscape --export-filename=$(basename $SCRIPT_DIR).png 00_template.svg &>/dev/null
inkscape --export-filename=$(basename $SCRIPT_DIR).pdf 00_template.svg &>/dev/null