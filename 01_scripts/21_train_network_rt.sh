#!/bin/bash
#Copyright 2023. TU Graz. Institute of Biomedical Imaging.
#Author: Moritz Blumenthal

set -eu
SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )

NET=$(readlink -f $1)
cd $NET

source config.sh

TRNDIR=${TRNDIR:-$SCRIPT_DIR/../00_data}

WORKDIR=`mktemp -d 2>/dev/null || mktemp -d -t 'mytmpdir'`
trap 'rm -rf "$WORKDIR"' EXIT
echo $WORKDIR

TRNDIR=$TRNDIR/$DATASET/
PAT=$TRNDIR/pat
KSP=$TRNDIR/ksp
TRJ=$TRNDIR/trj

if [[ "$NETWORK" == *"--conv-time-causal"* ]]; then
	S=$((65/SPOKES+(TIME-1)*ITER))
	E=$(bart show -d 10 $KSP)
else
	S=$((65/SPOKES+(TIME/2)*ITER))
	T=$(((TIME/2)*ITER))
	E=$(($(bart show -d 10 $KSP) - T))
fi

BR=$(($(bart show -d 1 $KSP) / 2))

bart scale $OS $TRJ $WORKDIR/trj
TRJ=$WORKDIR/trj
DIMS=$(LC_NUMERIC="en_US.UTF-8" printf "%.0f" $(echo "$OS*$BR" | bc))

bart copy $KSP $WORKDIR/ksp
KSP=$WORKDIR/ksp

MPIRUN="${MPIRUN:-}"

# take mpi parameter from slurm job allocation
if [[ ! -z "${SLURM_JOB_ID:-}" ]] ; then
	MPIRUN="mpirun --bind-to none "
fi

$MPIRUN bart nlinvnet --train -g -x${DIMS}:${DIMS}:1 \
	--sens-os=${COS} $NETWORK $TRAINING --temporal-train-mask=${S}:${E} \
	--trajectory=$TRJ --pattern=$PAT $KSP weights $KSP >> log.log
