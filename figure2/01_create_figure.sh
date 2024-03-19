#!/bin/bash
#Copyright 2023. TU Graz. Institute of Biomedical Imaging.
#Author: Moritz Blumenthal

set -eu
SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )
cd $SCRIPT_DIR

RAWDIR=${RAWDIR:-../00_data/10_raw_data}
RAW=$(readlink -f $RAWDIR/rt_sa/vol0056_vis1)

WDIR=$(mktemp -d 2>/dev/null || mktemp -d -t 'mytmpdir')
trap 'rm -rf "$WDIR"' EXIT
cd $WDIR
echo $WDIR

bart signal -F -I -1 0.5:1.5:4 -3 0.5:1.25:3 -r0.00267 -n1530 sig
bart reshape $(bart bitmask 0 1 5 6 7) 1530 12 1 1 1 sig $SCRIPT_DIR/sig

cd $SCRIPT_DIR
python3 02_basis.py
cd $WDIR

$SCRIPT_DIR/../01_scripts/10_reco_rt.sh -R -s10                  -C10 -O2   $RAW $WDIR/img_20
$SCRIPT_DIR/../01_scripts/10_reco_rt.sh -R -s10 -P0.75 -N0.75 -V -C10 -O2   $RAW $WDIR/img_20_rovir
$SCRIPT_DIR/../01_scripts/10_reco_rt.sh -R -s10 -P0.75 -N0.75 -V -C10 -O1.5 $RAW $WDIR/img_15_rovir
$SCRIPT_DIR/../01_scripts/10_reco_rt.sh -R -s10 -P0.75 -N0.75    -C10 -O1.5 $RAW $WDIR/img_15

TIME=27

bart slice 10 $TIME img_20 img_20_slc
bart slice 10 $TIME img_15_rovir img_15_rovir_slc
bart slice 10 $TIME img_20_rovir img_20_rovir_slc
bart slice 10 $TIME img_15 img_15_slc

bart slice 10 $TIME img_20_col col_20_slc
bart slice 10 $TIME img_15_rovir_col col_15_rovir_slc
bart slice 10 $TIME img_20_rovir_col col_20_rovir_slc
bart slice 10 $TIME img_15_col col_15_slc

bart fmac img_20_slc col_20_slc cim_20
bart fmac img_15_rovir_slc col_15_rovir_slc cim_15_rovir
bart fmac img_20_rovir_slc col_20_rovir_slc cim_20_rovir
bart fmac img_15_slc col_15_slc cim_15

bart rss 8 cim_20 rss_20
bart rss 8 cim_15_rovir rss_15_rovir
bart rss 8 cim_20_rovir rss_20_rovir
bart rss 8 cim_15 rss_15



CON="$($SCRIPT_DIR/../01_scripts/53_read_view.sh $SCRIPT_DIR/view.sh)"
CON_CIM="$($SCRIPT_DIR/../01_scripts/53_read_view.sh $SCRIPT_DIR/view_cim.sh)"

cfl2png -z3 $CON 	rss_20		$SCRIPT_DIR/twofold
cfl2png -z3 $CON 	rss_20_rovir	$SCRIPT_DIR/twofold_rovir
cfl2png -z3 $CON 	rss_15_rovir	$SCRIPT_DIR/reco_rovir
cfl2png -z3 $CON 	rss_15		$SCRIPT_DIR/reco
cfl2png -z3 $CON_CIM	cim_15_rovir	$SCRIPT_DIR/cim_rovir

cd $SCRIPT_DIR
inkscape --export-filename=$(basename $SCRIPT_DIR).eps 00_template.svg &>/dev/null
inkscape --export-filename=$(basename $SCRIPT_DIR).png 00_template.svg &>/dev/null
inkscape --export-filename=$(basename $SCRIPT_DIR).pdf 00_template.svg &>/dev/null
