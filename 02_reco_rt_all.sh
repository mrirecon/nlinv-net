#!/bin/bash
#Copyright 2023. TU Graz. Institute of Biomedical Imaging.
#Author: Moritz Blumenthal

set -eu
SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )

cd $SCRIPT_DIR

if [ -z "${PARALLEL:-}" ]; then 
    PARALLEL=1
fi

i=0

trap "kill 0" EXIT

for RAW in $RAWDIR/rt_sa_st/*.hdr ; do

	RAW=rt_sa_st/$(basename $RAW .hdr)

	if [[ $((i % PARALLEL)) -eq 0 ]] ; then
		wait
	fi

	(
	for NET in 11_networks_rt/*/ ; do
		01_scripts/41_eval_rt.sh -N $RAWDIR/$RAW $NET
	done
	) &

	i=$((i+1))
done

wait
