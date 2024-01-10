#!/bin/bash
#Copyright 2023. TU Graz. Institute of Biomedical Imaging.
#Author: Moritz Blumenthal

set -eu
SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )
cd $SCRIPT_DIR

if [ -z "${RECODIR:-}" ]; then 
    RECODIR="$(readlink -e $SCRIPT_DIR/../)"
fi

WDIR=$(mktemp -d 2>/dev/null || mktemp -d -t 'mytmpdir')
trap 'rm -rf "$WDIR"' EXIT
cd "$WDIR" || exit

CON_T1="$($SCRIPT_DIR/../01_scripts/53_read_view.sh $SCRIPT_DIR/view_T1.sh)"

SRC=$RECODIR/22_recos_t1/vol0084_vis1_apex/
bart extract 1 80 240 0 50 210 $SRC/04_pics_rovir_l0.001/img_T1 tmp	; cfl2png -z3 $CON_T1 tmp apex_rovir_T1_pics_1
bart extract 1 80 240 0 50 210 $SRC/04_pics_rovir_l0.002/img_T1 tmp	; cfl2png -z3 $CON_T1 tmp apex_rovir_T1_pics_2
bart extract 1 80 240 0 50 210 $SRC/04_pics_rovir_l0.003/img_T1 tmp	; cfl2png -z3 $CON_T1 tmp apex_rovir_T1_pics_3
bart extract 1 80 240 0 50 210 $SRC/04_pics_rovir_l0.008/img_T1 tmp	; cfl2png -z3 $CON_T1 tmp apex_rovir_T1_pics_8
bart extract 1 80 240 0 50 210 $SRC/24_rovir_resnet_mad_first/img_T1 tmp; cfl2png -z3 $CON_T1 tmp apex_rovir_T1_mad_first
bart extract 1 80 240 0 50 210 $SRC/03_pics_l0.001/img_T1 tmp		; cfl2png -z3 $CON_T1 tmp apex_T1_pics_1
bart extract 1 80 240 0 50 210 $SRC/03_pics_l0.002/img_T1 tmp		; cfl2png -z3 $CON_T1 tmp apex_T1_pics_2
bart extract 1 80 240 0 50 210 $SRC/03_pics_l0.003/img_T1 tmp		; cfl2png -z3 $CON_T1 tmp apex_T1_pics_3
bart extract 1 80 240 0 50 210 $SRC/03_pics_l0.008/img_T1 tmp		; cfl2png -z3 $CON_T1 tmp apex_T1_pics_8
bart extract 1 80 240 0 50 210 $SRC/14_resnet_mad_first/img_T1 tmp	; cfl2png -z3 $CON_T1 tmp apex_T1_mad_first

SRC=$RECODIR/22_recos_t1/vol0084_vis1_mid/
bart extract 1 80 240 0 50 210 $SRC/04_pics_rovir_l0.001/img_T1 tmp	; cfl2png -z3 $CON_T1 tmp mid_rovir_T1_pics_1
bart extract 1 80 240 0 50 210 $SRC/04_pics_rovir_l0.002/img_T1 tmp	; cfl2png -z3 $CON_T1 tmp mid_rovir_T1_pics_2
bart extract 1 80 240 0 50 210 $SRC/04_pics_rovir_l0.003/img_T1 tmp	; cfl2png -z3 $CON_T1 tmp mid_rovir_T1_pics_3
bart extract 1 80 240 0 50 210 $SRC/04_pics_rovir_l0.008/img_T1 tmp	; cfl2png -z3 $CON_T1 tmp mid_rovir_T1_pics_8
bart extract 1 80 240 0 50 210 $SRC/24_rovir_resnet_mad_first/img_T1 tmp; cfl2png -z3 $CON_T1 tmp mid_rovir_T1_mad_first
bart extract 1 80 240 0 50 210 $SRC/03_pics_l0.001/img_T1 tmp		; cfl2png -z3 $CON_T1 tmp mid_T1_pics_1
bart extract 1 80 240 0 50 210 $SRC/03_pics_l0.002/img_T1 tmp		; cfl2png -z3 $CON_T1 tmp mid_T1_pics_2
bart extract 1 80 240 0 50 210 $SRC/03_pics_l0.003/img_T1 tmp		; cfl2png -z3 $CON_T1 tmp mid_T1_pics_3
bart extract 1 80 240 0 50 210 $SRC/03_pics_l0.008/img_T1 tmp		; cfl2png -z3 $CON_T1 tmp mid_T1_pics_8
bart extract 1 80 240 0 50 210 $SRC/14_resnet_mad_first/img_T1 tmp	; cfl2png -z3 $CON_T1 tmp mid_T1_mad_first

SRC=$RECODIR/22_recos_t1/vol0084_vis1_base/
bart extract 1 80 240 0 50 210 $SRC/04_pics_rovir_l0.001/img_T1 tmp	; cfl2png -z3 $CON_T1 tmp base_rovir_T1_pics_1
bart extract 1 80 240 0 50 210 $SRC/04_pics_rovir_l0.002/img_T1 tmp	; cfl2png -z3 $CON_T1 tmp base_rovir_T1_pics_2
bart extract 1 80 240 0 50 210 $SRC/04_pics_rovir_l0.003/img_T1 tmp	; cfl2png -z3 $CON_T1 tmp base_rovir_T1_pics_3
bart extract 1 80 240 0 50 210 $SRC/04_pics_rovir_l0.008/img_T1 tmp	; cfl2png -z3 $CON_T1 tmp base_rovir_T1_pics_8
bart extract 1 80 240 0 50 210 $SRC/24_rovir_resnet_mad_first/img_T1 tmp; cfl2png -z3 $CON_T1 tmp base_rovir_T1_mad_first
bart extract 1 80 240 0 50 210 $SRC/03_pics_l0.001/img_T1 tmp		; cfl2png -z3 $CON_T1 tmp base_T1_pics_1
bart extract 1 80 240 0 50 210 $SRC/03_pics_l0.002/img_T1 tmp		; cfl2png -z3 $CON_T1 tmp base_T1_pics_2
bart extract 1 80 240 0 50 210 $SRC/03_pics_l0.003/img_T1 tmp		; cfl2png -z3 $CON_T1 tmp base_T1_pics_3
bart extract 1 80 240 0 50 210 $SRC/03_pics_l0.008/img_T1 tmp		; cfl2png -z3 $CON_T1 tmp base_T1_pics_8
bart extract 1 80 240 0 50 210 $SRC/14_resnet_mad_first/img_T1 tmp	; cfl2png -z3 $CON_T1 tmp base_T1_mad_first

bart index 1 2000 $WDIR/idx1
bart flip 2 $WDIR/idx1 $WDIR/idx
bart scale 0.001 $WDIR/idx $WDIR/scl
bart repmat 0 100 $WDIR/scl $WDIR/scl2

cfl2png -CV $WDIR/scl2 scale.png

cp $SCRIPT_DIR/00_template.svg ./

inkscape --export-filename=$SCRIPT_DIR/$(basename $SCRIPT_DIR).eps 00_template.svg &>/dev/null
inkscape --export-filename=$SCRIPT_DIR/$(basename $SCRIPT_DIR).png 00_template.svg &>/dev/null
inkscape --export-filename=$SCRIPT_DIR/$(basename $SCRIPT_DIR).pdf 00_template.svg &>/dev/null