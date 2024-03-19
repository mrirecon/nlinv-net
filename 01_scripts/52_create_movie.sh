#!/bin/bash
#Copyright 2023. TU Graz. Institute of Biomedical Imaging.
#Author: Moritz Blumenthal

set -eu
SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )

SVG=$(readlink -f $1)
CONFIG=$($SCRIPT_DIR/53_read_view.sh $2)
OUT=$(readlink -f $3)
shift 3

WORKDIR=`mktemp -d 2>/dev/null || mktemp -d -t 'mytmpdir'`
trap 'rm -rf "$WORKDIR"' EXIT


TDIR=${WORKDIR//./_}
mv $WORKDIR $TDIR
WORKDIR=$TDIR

echo $TDIR

mkdir $TDIR/placeholder/

i=1
while (($#)); do

	cfl2png -z2 -S64511 $CONFIG $1 $TDIR/img${i}_
	cfl2png -z2 -S65535 $CONFIG $1 $TDIR/placeholder/img${i}_

	i=$((i+1))
	shift 1
done

cd $TDIR

$SCRIPT_DIR/51_annotate_inkscape.sh $SVG $OUT.png placeholder/img*.png

for f in img1_*png ; do

	f2=$(basename $f .png)
	out="${f2//img1_/combined_}.png"
	pos="${f2//img1_/}"
	$SCRIPT_DIR/51_annotate_inkscape.sh $SVG $out $(ls img*${pos}.png)&
done

wait

for f in $WORKDIR/combined_*_f0000*png ; do

	ffmpeg -y -framerate 30 -i "${f//_f0000/_f%04d}" -c:v libx264 -f mp4 -vf format=yuv420p $OUT.mp4
done

