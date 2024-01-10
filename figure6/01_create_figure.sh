#!/bin/bash
#Copyright 2023. TU Graz. Institute of Biomedical Imaging.
#Author: Moritz Blumenthal

set -eu
SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )
cd $SCRIPT_DIR

if [ -z "${RECODIR:-}" ]; then 
    RECODIR="$(readlink -e $SCRIPT_DIR/../)"
fi

SRC=$RECODIR/22_recos_t1/vol0084_vis1_mid/

WDIR=$(mktemp -d 2>/dev/null || mktemp -d -t 'mytmpdir')
trap 'rm -rf "$WDIR"' EXIT
cd "$WDIR" || exit

bart vec 1 3 15 20 $WDIR/v
bart transpose 0 6 $WDIR/v $WDIR/v2
bart repmat 0 256 $WDIR/v2 $WDIR/vt
bart repmat 1 200 $WDIR/vt $WDIR/v3
bart ones 7 256 56 1 1 1 1 4 $WDIR/v4
bart join 1 $WDIR/v3 $WDIR/v4 $WDIR/v5
bart transpose 0 1 $WDIR/v5 $WDIR/v6

CON="$($SCRIPT_DIR/../01_scripts/53_read_view.sh $SCRIPT_DIR/view.sh)"
CON_T1="$($SCRIPT_DIR/../01_scripts/53_read_view.sh $SCRIPT_DIR/view_T1.sh)"

bart fmac $WDIR/v6 $SRC/01_nlinv/img $WDIR/img ; 		cfl2png $CON $WDIR/img coeff_nlinv
bart fmac $WDIR/v6 $SRC/03_pics_l0.003/img $WDIR/img ; 		cfl2png $CON $WDIR/img coeff_pics
bart fmac $WDIR/v6 $SRC/11_resnet_mse/img $WDIR/img ; 		cfl2png $CON $WDIR/img coeff_mse
bart fmac $WDIR/v6 $SRC/12_resnet_mad/img $WDIR/img ; 		cfl2png $CON $WDIR/img coeff_mad
bart fmac $WDIR/v6 $SRC/13_resnet_mse_first/img $WDIR/img ; 	cfl2png $CON $WDIR/img coeff_mse_first
bart fmac $WDIR/v6 $SRC/14_resnet_mad_first/img $WDIR/img ; 	cfl2png $CON $WDIR/img coeff_mad_first

cfl2png $CON_T1 $SRC/01_nlinv/img_T1	 	T1_nlinv
cfl2png $CON_T1 $SRC/03_pics_l0.003/img_T1	T1_pics
cfl2png $CON_T1 $SRC/11_resnet_mse/img_T1	T1_mse
cfl2png $CON_T1 $SRC/12_resnet_mad/img_T1	T1_mad
cfl2png $CON_T1 $SRC/13_resnet_mse_first/img_T1	T1_mse_first
cfl2png $CON_T1 $SRC/14_resnet_mad_first/img_T1	T1_mad_first

bart index 1 2000 $WDIR/idx1
bart flip 2 $WDIR/idx1 $WDIR/idx
bart scale 0.001 $WDIR/idx $WDIR/scl
bart repmat 0 100 $WDIR/scl $WDIR/scl2

cfl2png -CV $WDIR/scl2 scale.png

cp $SCRIPT_DIR/00_template.svg ./

inkscape --export-filename=$SCRIPT_DIR/$(basename $SCRIPT_DIR).eps 00_template.svg &>/dev/null
inkscape --export-filename=$SCRIPT_DIR/$(basename $SCRIPT_DIR).png 00_template.svg &>/dev/null
inkscape --export-filename=$SCRIPT_DIR/$(basename $SCRIPT_DIR).pdf 00_template.svg &>/dev/null
