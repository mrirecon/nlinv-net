#!/bin/bash
#Copyright 2023. TU Graz. Institute of Biomedical Imaging.
#Author: Moritz Blumenthal

set -eu
SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )
DATALIST=$SCRIPT_DIR/13_T1_hres.txt

SCRIPT_DIR=$SCRIPT_DIR/../../01_scripts

RAWDIR=${RAWDIR:-$SCRIPT_DIR/../00_data/10_raw_data}
TRNDIR=${TRNDIR:-$SCRIPT_DIR/../00_data/11_train_data}/03_t1_svd/
mkdir -p $TRNDIR

$SCRIPT_DIR/02_create_basis.sh 0.00267 1530 $TRNDIR/

DAT="
t1_sa/vol0001_vis2_apex
t1_sa/vol0001_vis2_apex2
t1_sa/vol0001_vis2_base
t1_sa/vol0001_vis2_base2
t1_sa/vol0001_vis2_mid
t1_sa/vol0001_vis2_mid2
t1_sa/vol0005_vis2_apex
t1_sa/vol0005_vis2_apex2
t1_sa/vol0005_vis2_base
t1_sa/vol0005_vis2_base2
t1_sa/vol0005_vis2_mid
t1_sa/vol0005_vis2_mid2
t1_sa/vol0008_vis2_apex
t1_sa/vol0008_vis2_base
t1_sa/vol0008_vis2_base
t1_sa/vol0008_vis2_base2
t1_sa/vol0008_vis2_mid
t1_sa/vol0008_vis2_mid2
t1_sa/vol0009_vis2_apex
t1_sa/vol0009_vis2_apex2
t1_sa/vol0009_vis2_base
t1_sa/vol0009_vis2_base2
t1_sa/vol0009_vis2_mid
t1_sa/vol0009_vis2_mid2
t1_sa/vol0010_vis2_apex
t1_sa/vol0010_vis2_apex2
t1_sa/vol0010_vis2_base
t1_sa/vol0010_vis2_base2
t1_sa/vol0010_vis2_mid
t1_sa/vol0010_vis2_mid2
t1_sa/vol0010_vis2_mid3
t1_sa/vol0011_vis2_apex
t1_sa/vol0011_vis2_apex2
t1_sa/vol0011_vis2_base
t1_sa/vol0011_vis2_base2
t1_sa/vol0011_vis2_mid
t1_sa/vol0011_vis2_mid2
t1_sa/vol0017_vis2_apex
t1_sa/vol0017_vis2_apex2
t1_sa/vol0017_vis2_base
t1_sa/vol0017_vis2_base2
t1_sa/vol0017_vis2_mid
t1_sa/vol0017_vis2_mid2
t1_sa/vol0017_vis3_apex
t1_sa/vol0017_vis3_base
t1_sa/vol0017_vis3_mid
t1_sa/vol0017_vis4_apex
t1_sa/vol0017_vis4_apex2
t1_sa/vol0017_vis4_base
t1_sa/vol0017_vis4_base2
t1_sa/vol0017_vis4_mid
t1_sa/vol0017_vis4_mid2
t1_sa/vol0027_vis1_apex
t1_sa/vol0027_vis1_apex2
t1_sa/vol0027_vis1_base
t1_sa/vol0027_vis1_base2
t1_sa/vol0027_vis1_mid
t1_sa/vol0027_vis1_mid2
t1_sa/vol0028_vis1_apex
t1_sa/vol0028_vis1_apex2
t1_sa/vol0028_vis1_base
t1_sa/vol0028_vis1_base2
t1_sa/vol0028_vis1_mid
t1_sa/vol0028_vis1_mid2
t1_sa/vol0028_vis2_apex
t1_sa/vol0028_vis2_base
t1_sa/vol0028_vis2_mid
t1_sa/vol0028_vis3_apex
t1_sa/vol0028_vis3_base
t1_sa/vol0028_vis3_base2
t1_sa/vol0028_vis3_mid
t1_sa/vol0028_vis3_mid2
t1_sa/vol0029_vis1_apex
t1_sa/vol0029_vis1_apex2
t1_sa/vol0029_vis1_base
t1_sa/vol0029_vis1_base2
t1_sa/vol0029_vis1_mid
t1_sa/vol0029_vis1_mid2
t1_sa/vol0029_vis2_apex
t1_sa/vol0029_vis2_apex2
t1_sa/vol0029_vis2_base
t1_sa/vol0029_vis2_base2
t1_sa/vol0029_vis2_mid
t1_sa/vol0029_vis2_mid2
t1_sa/vol0030_vis1_apex
t1_sa/vol0030_vis1_apex2
t1_sa/vol0030_vis1_base
t1_sa/vol0030_vis1_base2
t1_sa/vol0030_vis1_mid
t1_sa/vol0030_vis1_mid2
t1_sa/vol0030_vis2_apex
t1_sa/vol0030_vis2_apex2
t1_sa/vol0030_vis2_base
t1_sa/vol0030_vis2_base2
t1_sa/vol0030_vis2_mid
t1_sa/vol0030_vis2_mid2
t1_sa/vol0031_vis1_apex
t1_sa/vol0031_vis1_apex2
t1_sa/vol0031_vis1_base
t1_sa/vol0031_vis1_base2
t1_sa/vol0031_vis1_mid
t1_sa/vol0031_vis1_mid2
t1_sa/vol0032_vis1_apex
t1_sa/vol0032_vis1_apex2
t1_sa/vol0032_vis1_base
t1_sa/vol0032_vis1_base2
t1_sa/vol0032_vis1_base3
t1_sa/vol0032_vis1_mid
t1_sa/vol0032_vis1_mid2
t1_sa/vol0034_vis1_apex
t1_sa/vol0034_vis1_base
t1_sa/vol0034_vis1_mid
t1_sa/vol0035_vis1_apex
t1_sa/vol0035_vis1_base
t1_sa/vol0035_vis1_mid
t1_sa/vol0036_vis1_apex
t1_sa/vol0036_vis1_base
t1_sa/vol0036_vis1_mid
t1_sa/vol0037_vis1_apex
t1_sa/vol0037_vis1_base
t1_sa/vol0037_vis1_mid
t1_sa/vol0038_vis1_apex
t1_sa/vol0038_vis1_base
t1_sa/vol0038_vis1_mid
t1_sa/vol0039_vis1_apex
t1_sa/vol0039_vis1_base
t1_sa/vol0039_vis1_mid
t1_sa/vol0039_vis2_apex
t1_sa/vol0039_vis2_apex2
t1_sa/vol0039_vis2_apex3
t1_sa/vol0039_vis2_base
t1_sa/vol0039_vis2_base2
t1_sa/vol0039_vis2_base3
t1_sa/vol0039_vis2_mid
t1_sa/vol0039_vis2_mid2
t1_sa/vol0039_vis2_mid3
t1_sa/vol0040_vis1_apex
t1_sa/vol0040_vis1_base
t1_sa/vol0040_vis1_mid
t1_sa/vol0040_vis2_apex
t1_sa/vol0040_vis2_apex2
t1_sa/vol0040_vis2_base
t1_sa/vol0040_vis2_base2
t1_sa/vol0040_vis2_mid
t1_sa/vol0040_vis2_mid2
t1_sa/vol0041_vis1_apex
t1_sa/vol0041_vis1_base
t1_sa/vol0041_vis1_mid
t1_sa/vol0043_vis1_apex
t1_sa/vol0043_vis1_base
t1_sa/vol0043_vis1_mid
t1_sa/vol0044_vis1_apex
t1_sa/vol0044_vis1_base
t1_sa/vol0044_vis1_mid
t1_sa/vol0045_vis1_apex
t1_sa/vol0045_vis1_base
t1_sa/vol0045_vis1_base2
t1_sa/vol0045_vis1_mid
t1_sa/vol0046_vis1_apex
t1_sa/vol0046_vis1_base
t1_sa/vol0046_vis1_mid
t1_sa/vol0047_vis1_apex
t1_sa/vol0047_vis1_base
t1_sa/vol0047_vis1_mid2
t1_sa/vol0047_vis1_mid3
t1_sa/vol0047_vis1_mid4
t1_sa/vol0048_vis1_apex
t1_sa/vol0048_vis1_base
t1_sa/vol0048_vis1_mid
t1_sa/vol0048_vis2_apex
t1_sa/vol0048_vis2_apex2
t1_sa/vol0048_vis2_base2
t1_sa/vol0048_vis2_base3
t1_sa/vol0048_vis2_mid
t1_sa/vol0048_vis2_mid2
t1_sa/vol0049_vis1_base
t1_sa/vol0049_vis1_mid
t1_sa/vol0051_vis1_apex
t1_sa/vol0051_vis1_base
t1_sa/vol0051_vis1_mid
t1_sa/vol0052_vis1_apex
t1_sa/vol0052_vis1_base
t1_sa/vol0052_vis1_mid
t1_sa/vol0053_vis1_apex
t1_sa/vol0053_vis1_apex2
t1_sa/vol0053_vis1_base
t1_sa/vol0053_vis1_mid
t1_sa/vol0053_vis1_mid2
t1_sa/vol0053_vis1_mid3
t1_sa/vol0054_vis1_apex
t1_sa/vol0054_vis1_base
t1_sa/vol0054_vis1_mid
t1_sa/vol0055_vis1_apex
t1_sa/vol0055_vis1_base
t1_sa/vol0055_vis1_mid
t1_sa/vol0056_vis1_apex
t1_sa/vol0056_vis1_base
t1_sa/vol0056_vis1_mid
t1_sa/vol0057_vis1_apex
t1_sa/vol0057_vis1_base
t1_sa/vol0057_vis1_mid
t1_sa/vol0058_vis1_apex
t1_sa/vol0058_vis1_base
t1_sa/vol0058_vis1_mid
t1_sa/vol0058_vis1_mid2
t1_sa/vol0059_vis1_apex
t1_sa/vol0059_vis1_base
t1_sa/vol0059_vis1_mid
t1_sa/vol0060_vis1_apex
t1_sa/vol0060_vis1_base
t1_sa/vol0060_vis1_mid
t1_sa/vol0061_vis1_apex
t1_sa/vol0061_vis1_apex2
t1_sa/vol0061_vis1_base
t1_sa/vol0061_vis1_base2
t1_sa/vol0061_vis1_mid
t1_sa/vol0062_vis1_apex
t1_sa/vol0062_vis1_base
t1_sa/vol0062_vis1_mid
t1_sa/vol0062_vis1_mid
t1_sa/vol0066_vis1_apex
t1_sa/vol0066_vis1_base
t1_sa/vol0066_vis1_mid
t1_sa/vol0067_vis1_apex
t1_sa/vol0067_vis1_base
t1_sa/vol0067_vis1_mid
t1_sa/vol0069_vis1_apex
t1_sa/vol0069_vis1_base
t1_sa/vol0069_vis1_mid
t1_sa/vol0070_vis1_apex
t1_sa/vol0070_vis1_apex2
t1_sa/vol0070_vis1_base
t1_sa/vol0070_vis1_mid
"

i=0

WORKDIR=`mktemp -d 2>/dev/null || mktemp -d -t 'mytmpdir'`
trap 'rm -rf "$WORKDIR"' EXIT
cd $WORKDIR

for SRC in $DAT ; do

	$SCRIPT_DIR/01_prep.sh -G9 -P0.75 -N0.75 -B1 -C10 -M $RAWDIR/${SRC}_sg1_idx_dia.txt $RAWDIR/$SRC ./

	if [ 0 -eq $i ] ; then

		bart copy trj $TRNDIR/trj
		bart copy ksp $TRNDIR/ksp
		bart copy msk $TRNDIR/pat
	else
		bart join -a 15 trj $TRNDIR/trj
		bart join -a 15 ksp $TRNDIR/ksp
		bart join -a 15 msk $TRNDIR/pat
	fi

	i=$((i+1))
	echo "$i datasets coverted!"
done

