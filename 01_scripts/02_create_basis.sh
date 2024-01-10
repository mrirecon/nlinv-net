#!/bin/bash
#Copyright 2023. TU Graz. Institute of Biomedical Imaging.
#Author: Moritz Blumenthal

set -eu
SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )

helpstr=$(cat <<- EOF
Creation of Subspace Basis and Inversion Times from Repetition Time

-h help
EOF
)

usage="Usage: $0 TR rep <out dir>"
BINNING=1

while getopts "B:C:s:M:" opt; do
	case $opt in
	B)
		BINNING=$OPTARG
	;;
    esac
done

shift $((OPTIND - 1))

if [ $# -lt 3 ] ; then

	echo "$usage" >&2
	exit 1
fi

TR="$1"
REP="$2"
OUT_DIR=$(readlink -f "$3")

mkdir -p $OUT_DIR

WORKDIR=$(mktemp -d 2>/dev/null || mktemp -d -t 'mytmpdir')
trap 'rm -rf "$WORKDIR"' EXIT
cd "$WORKDIR" || exit


#SUBSPACE PARAMS
N_COE=4
N_R1s=1000
T1_MIN=0.1
T1_MAX=4
N_FA=100
FA_MIN=0.5
FA_MAX=1.1

REP=$((REP/BINNING))
REP=$((REP*BINNING))


bart index 5 $REP tmp1 #Create an array counting from 0 to {$BIN_REP-1} in dimensions {5}.
bart scale $TR tmp1 tmp

REP=$((REP/BINNING))
bart reshape $(bart bitmask 2 5) $BINNING $REP tmp tmp1
REP=$((REP*BINNING))
bart avg $(bart bitmask 2) tmp1 $OUT_DIR/TI

bart signal -F -I -1 $T1_MIN:$T1_MAX:$N_R1s -5 2:4.4:$N_FA -r$TR -n$REP --short-TR-LL-approx sig #Analytical simulation tool.

REP=$((REP/BINNING))
bart reshape $(bart bitmask 2 5) $BINNING $REP sig sig2
REP=$((REP*BINNING))
bart avg $(bart bitmask 2) sig2 $OUT_DIR/dict


#simulated courves are highly correlated and can be represented by only few principle components
bart reshape $(bart bitmask 6 10) $((N_R1s * N_FA)) 1 $OUT_DIR/dict sig2
bart squeeze sig2 sig
bart svd -e sig U S V 
bart extract 1 0 $N_COE U basis 
bart transpose 1 6 basis basis1
bart transpose 0 5 basis1 $OUT_DIR/basis



