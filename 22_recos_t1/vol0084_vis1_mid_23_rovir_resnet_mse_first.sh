#!/bin/bash
#Copyright 2023. TU Graz. Institute of Biomedical Imaging.
#Author: Moritz Blumenthal

set -eu
SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )

cd $SCRIPT_DIR/..

RAWDIR=${RAWDIR:-$SCRIPT_DIR/../00_data/10_raw_data}
RAW=$RAWDIR/t1_sa/vol0084_vis1_mid

NET=12_networks_t1/23_rovir_resnet_mse_first
01_scripts/42_eval_t1.sh $RAW $NET
