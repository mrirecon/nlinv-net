#!/bin/bash
#Copyright 2023. TU Graz. Institute of Biomedical Imaging.
#Author: Moritz Blumenthal

set -u
SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )
cd $SCRIPT_DIR/../

if [ -z "${RECODIR:-}" ]; then 
    RECODIR="$SCRIPT_DIR/../"
fi

rm -r $RECODIR/21_recos_rt/vol0082_vis1_slc16
rm -r $RECODIR/21_recos_rt/vol0056_vis1_slc13

rm -r $RECODIR/22_recos_t1/00_prep
rm -r $RECODIR/22_recos_t1/vol0084_vis1_apex
rm -r $RECODIR/22_recos_t1/vol0084_vis1_base
rm -r $RECODIR/22_recos_t1/vol0084_vis1_mid

exit 0
