#!/bin/bash
#Copyright 2023. TU Graz. Institute of Biomedical Imaging.
#Author: Moritz Blumenthal

set -eu
SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )

usage="Usage: $0 <drawing.svg> <output> <images>"

WIDTH=""

while getopts "hw:" opt; do
	case $opt in
	w)
		WIDTH=" --export-width=$OPTARG"
	;;
	h)
		echo "No help available!"
		exit 0
	;;
	\?)
		exit 1
	;;
	esac
done

shift $((OPTIND - 1))

if [ $# -lt 3 ] ; then

	echo "$usage" >&2
	exit 1
fi

WORKDIR=$(mktemp -d 2>/dev/null || mktemp -d -t 'mytmpdir')
trap 'rm -rf "$WORKDIR"' EXIT

cp $1 $WORKDIR/drawing.svg
shift 1

OUT=$(readlink -f "$1")
shift 1


i=1
while (($#)); do

	if [[ "DUMMY" == "$1" ]] ; then
		convert -size 800x800 canvas:white $WORKDIR/img${i}.png
		continue
	fi

	cp $1 $WORKDIR/img${i}.png
	i=$((i+1))
	shift 1
done

cd $WORKDIR

inkscape --export-filename=$OUT drawing.svg &>/dev/null

