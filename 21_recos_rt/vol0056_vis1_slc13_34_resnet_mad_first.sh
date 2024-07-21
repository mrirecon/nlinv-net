#!/bin/bash
#Copyright 2023. TU Graz. Institute of Biomedical Imaging.
#Author: Moritz Blumenthal

set -eu
SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )

cd $SCRIPT_DIR/..

RAWDIR=${RAWDIR:-$SCRIPT_DIR/../00_data/10_raw_data}
RAW=$RAWDIR/rt_sa/vol0056_vis1

01_scripts/41_eval_rt.sh -s13 -N $RAW 11_networks_rt/34_resnet_mad_first
