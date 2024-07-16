#!/bin/bash
#Copyright 2023. TU Graz. Institute of Biomedical Imaging.
#Author: Moritz Blumenthal

export BART_COMPAT_VERSION="v0.9.00"

FSIZE=$1
INPUT=$(readlink -f $2)
OUTPUT=$(readlink -f $3)

WORKDIR=$(mktemp -d 2>/dev/null || mktemp -d -t 'mytmpdir')
trap 'rm -rf "$WORKDIR"' EXIT

PAD=$((FSIZE-1))

bart resize -c 10 $(( PAD+$(bart show -d10 $INPUT) )) $INPUT $WORKDIR/tmp
bart -p$(bart bitmask 13) -r $WORKDIR/tmp filter -m10 -l$FSIZE $WORKDIR/tmp $OUTPUT
