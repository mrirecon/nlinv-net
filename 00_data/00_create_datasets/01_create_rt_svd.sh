#!/bin/bash
#Copyright 2023. TU Graz. Institute of Biomedical Imaging.
#Author: Moritz Blumenthal

set -eu
SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )

RAWDIR=${RAWDIR:-$SCRIPT_DIR/../00_data/10_raw_data}
TRNDIR=${TRNDIR:-$SCRIPT_DIR/../00_data/11_train_data}/01_rt_svd/
mkdir -p $TRNDIR

i=0

WORKDIR=`mktemp -d 2>/dev/null || mktemp -d -t 'mytmpdir'`
trap 'rm -rf "$WORKDIR"' EXIT
cd $WORKDIR

LEN=26

DAT="
rt_sa/vol0001_vis1
rt_sa/vol0002_vis1
rt_sa/vol0003_vis1
rt_sa/vol0004_vis1
rt_sa/vol0005_vis1
rt_sa/vol0006_vis1
rt_sa/vol0007_vis1
rt_sa/vol0008_vis1
rt_sa/vol0009_vis1
rt_sa/vol0010_vis1
rt_sa/vol0011_vis1
rt_sa/vol0012_vis1
rt_sa/vol0013_vis1
rt_sa/vol0014_vis1
rt_sa/vol0015_vis1
rt_sa/vol0016_vis1
rt_sa/vol0017_vis1
rt_sa/vol0018_vis1
rt_sa/vol0019_vis1
rt_sa/vol0020_vis1
rt_sa/vol0021_vis1
rt_sa/vol0022_vis1
rt_sa/vol0023_vis1
rt_sa/vol0024_vis1
rt_sa/vol0025_vis1
rt_sa/vol0027_vis1
rt_sa/vol0032_vis1
rt_sa/vol0034_vis1
rt_sa/vol0035_vis1
rt_sa/vol0036_vis1
rt_sa/vol0037_vis1
rt_sa/vol0038_vis1
rt_sa/vol0039_vis1
rt_sa/vol0040_vis1
rt_sa/vol0041_vis1
rt_sa/vol0043_vis1
rt_sa/vol0044_vis1
rt_sa/vol0045_vis1
rt_sa/vol0046_vis1
rt_sa/vol0047_vis1
"


for SRC in $DAT ; do

	$SCRIPT_DIR/../../01_scripts/01_prep.sh -T5 -P0.75 -N0.75 -B13 -C10 $RAWDIR/$SRC ./

	SLC=$(bart show -d 13 ksp)
	REP=$(($(bart show -d 10 ksp)/LEN))

	bart resize 10 $((LEN*REP)) trj trj_tmp
	bart resize 10 $((LEN*REP)) ksp ksp_tmp

	bart reshape $(bart bitmask 10 13) $LEN $((REP*SLC)) trj_tmp trj_ext
	bart reshape $(bart bitmask 10 13) $LEN $((REP*SLC)) ksp_tmp ksp_ext

	if [ 0 -eq $i ] ; then

		bart transpose 13 15 trj_ext $TRNDIR/trj
		bart transpose 13 15 ksp_ext $TRNDIR/ksp
	else
		bart transpose 13 15 trj_ext trj
		bart transpose 13 15 ksp_ext ksp

		bart join -a 15 trj $TRNDIR/trj
		bart join -a 15 ksp $TRNDIR/ksp
	fi

	i=$((i+1))
	echo "$i datasets coverted!"
done

bart ones 11 1 320 $(bart show -d2 $TRNDIR/ksp) 1 1 1 1 1 1 1 $(bart show -d10 $TRNDIR/ksp) $TRNDIR/pat
