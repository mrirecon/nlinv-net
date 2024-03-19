#!/bin/bash
#Copyright 2023. TU Graz. Institute of Biomedical Imaging.
#Author: Moritz Blumenthal

set -eu
SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )
cd $SCRIPT_DIR/../

download()
(
	URL=$1
	DST=$2

	if [ ! -f "$DST" ] && [ ! -z "${DATA_ARCHIVE+x}" ] ; then
		
		REPO_NAME=$(<meta/name)
		if [ -f ${DATA_ARCHIVE}/${REPO_NAME}/$DST ] ; then
			cp ${DATA_ARCHIVE}/${REPO_NAME}/$DST $DST
		fi
	fi

	if [ ! -f "$DST" ]; then
		TMPFILE=$(mktemp)
   		wget -O $TMPFILE $URL
		mv $TMPFILE $DST
	fi
)

#Download Network Weights
download https://zenodo.org/records/10845041/files/11_networks_rt2.zip 11_networks_rt2.zip
download https://zenodo.org/records/10845041/files/12_networks_t1.zip 12_networks_t1.zip

unzip -o 11_networks_rt2.zip
unzip -o 12_networks_t1.zip


RAWDIR=${RAWDIR:-00_data/10_raw_data}

#Download Realtime Data
mkdir -p $RAWDIR/rt_sa/

download https://zenodo.org/record/10492455/files/vol0056_vis1.cfl $RAWDIR/rt_sa/vol0056_vis1.cfl
download https://zenodo.org/record/10492455/files/vol0056_vis1.hdr $RAWDIR/rt_sa/vol0056_vis1.hdr

download https://zenodo.org/record/10493095/files/vol0082_vis1.cfl $RAWDIR/rt_sa/vol0082_vis1.cfl
download https://zenodo.org/record/10493095/files/vol0082_vis1.hdr $RAWDIR/rt_sa/vol0082_vis1.hdr


#Download Inversion Recovery Data
mkdir -p $RAWDIR/t1_sa/

download https://zenodo.org/record/10492275/files/vol0084_vis1_apex.cfl $RAWDIR/t1_sa/vol0084_vis1_apex.cfl
download https://zenodo.org/record/10492275/files/vol0084_vis1_apex.hdr $RAWDIR/t1_sa/vol0084_vis1_apex.hdr
download https://zenodo.org/record/10492275/files/vol0084_vis1_apex_sg1_idx_dia.txt $RAWDIR/t1_sa/vol0084_vis1_apex_sg1_idx_dia.txt

download https://zenodo.org/record/10492275/files/vol0084_vis1_base.cfl $RAWDIR/t1_sa/vol0084_vis1_base.cfl
download https://zenodo.org/record/10492275/files/vol0084_vis1_base.hdr $RAWDIR/t1_sa/vol0084_vis1_base.hdr
download https://zenodo.org/record/10492275/files/vol0084_vis1_base_sg1_idx_dia.txt $RAWDIR/t1_sa/vol0084_vis1_base_sg1_idx_dia.txt

download https://zenodo.org/record/10492275/files/vol0084_vis1_mid.cfl $RAWDIR/t1_sa/vol0084_vis1_mid.cfl
download https://zenodo.org/record/10492275/files/vol0084_vis1_mid.hdr $RAWDIR/t1_sa/vol0084_vis1_mid.hdr
download https://zenodo.org/record/10492275/files/vol0084_vis1_mid_sg1_idx_dia.txt $RAWDIR/t1_sa/vol0084_vis1_mid_sg1_idx_dia.txt


