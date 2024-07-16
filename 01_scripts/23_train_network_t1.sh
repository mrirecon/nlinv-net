#!/bin/bash
#Copyright 2023. TU Graz. Institute of Biomedical Imaging.
#Author: Moritz Blumenthal

export BART_COMPAT_VERSION="v0.9.00"

set -eu
SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )

NET=$(readlink -f $1)
cd $NET

source config.sh

BAS=$(readlink -f basis)

if ! [ -z ${MSK+x} ]; then
	MSK=$(readlink -f $MSK)
fi

WORKDIR=`mktemp -d 2>/dev/null || mktemp -d -t 'mytmpdir'`
trap 'rm -rf "$WORKDIR"' EXIT
echo $WORKDIR

TRNDIR=${TRNDIR:-$SCRIPT_DIR/../00_data}/$DATASET/
PAT=$TRNDIR/pat
KSP=$TRNDIR/ksp
TRJ=$TRNDIR/trj

BR=$(($(bart show -d 1 $KSP) / 2))

bart scale $OS $TRJ $WORKDIR/trj
TRJ=$WORKDIR/trj
DIMS=$(LC_NUMERIC="en_US.UTF-8" printf "%.0f" $(echo "$OS*$BR" | bc))

MPIRUN="${MPIRUN:-}"

# take mpi parameter from slurm job allocation
if [[ ! -z "${SLURM_JOB_ID:-}" ]] ; then
	MPIRUN="mpirun --bind-to none "
fi

$MPIRUN bart nlinvnet --train -g -x${DIMS}:${DIMS}:1 \
	--sens-os=${COS} $NETWORK $TRAINING \
	--trajectory=$TRJ --pattern=$PAT --basis=$BAS $KSP weights $KSP >> log.log
