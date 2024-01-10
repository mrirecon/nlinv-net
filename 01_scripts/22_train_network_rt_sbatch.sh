#!/bin/bash
#Copyright 2023. TU Graz. Institute of Biomedical Imaging.
#Author: Moritz Blumenthal

set -eu
SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )

NET=$(readlink -f $1)
cd $NET

source config.sh

WORKDIR=`mktemp -d 2>/dev/null || mktemp -d -t 'mytmpdir'`
trap 'rm -rf "$WORKDIR"' EXIT

echo "#!/bin/bash" >> $WORKDIR/script.sh

INIT=$(readlink -f $SCRIPT_DIR/../init.sh)
echo "source $INIT" >> $WORKDIR/script.sh
echo "export PATH=$(dirname $(which bart))/:\$PATH" >> $WORKDIR/script.sh
echo "export TRNDIR=$TRNDIR" >> $WORKDIR/script.sh
echo "cd $NET" >> $WORKDIR/script.sh
echo "bash $SCRIPT_DIR/21_train_network_rt.sh ./" >> $WORKDIR/script.sh

cat $WORKDIR/script.sh

sbatch $SBATCH_OPTIONS $WORKDIR/script.sh

