#!/bin/bash
#Copyright 2023. TU Graz. Institute of Biomedical Imaging.
#Author: Moritz Blumenthal

source $1

CONFIG=""

CONFIG="-x$VIEW_XDIM -y$VIEW_YDIM -l$VIEW_WINLOW -u$VIEW_WINHIGH"

if [[ 1 -eq $VIEW_ABSOLUTE_WINDOWING ]] ; then CONFIG+=" -A" ; fi

if [[ "NLINEAR" == "$VIEW_INTERPOLATION" ]] ; then CONFIG+=" -IL" ; fi
if [[ "NLINEARMAG" == "$VIEW_INTERPOLATION" ]] ; then CONFIG+=" -IM" ; fi
if [[ "NEAREST" == "$VIEW_INTERPOLATION" ]] ; then CONFIG+=" -IN" ; fi
if [[ "LIINCO" == "$VIEW_INTERPOLATION" ]] ; then CONFIG+=" -IC" ; fi

if [[ "MAGN" == "$VIEW_MODE" ]] 	; then CONFIG+=" -CM" ; fi
if [[ "MAGN_VIRIDS" == "$VIEW_MODE" ]]	; then CONFIG+=" -CV" ; fi
if [[ "CMPL" == "$VIEW_MODE" ]]		; then CONFIG+=" -CC" ; fi
if [[ "CMPL_MYGBM" == "$VIEW_MODE" ]]	; then CONFIG+=" -CG" ; fi
if [[ "PHSE" == "$VIEW_MODE" ]]		; then CONFIG+=" -CP" ; fi
if [[ "PHSE_MYGBM" == "$VIEW_MODE" ]]	; then CONFIG+=" -CY" ; fi
if [[ "REAL" == "$VIEW_MODE" ]] 	; then CONFIG+=" -CR" ; fi
if [[ "FLOW" == "$VIEW_MODE" ]] 	; then CONFIG+=" -CF" ; fi

if [[ "OO" == "$VIEW_FLIP" ]] ; then CONFIG+=" -FO" ; fi
if [[ "XO" == "$VIEW_FLIP" ]] ; then CONFIG+=" -FX" ; fi
if [[ "OY" == "$VIEW_FLIP" ]] ; then CONFIG+=" -FY" ; fi
if [[ "XY" == "$VIEW_FLIP" ]] ; then CONFIG+=" -FZ" ; fi

CONFIG+=" -p $VIEW_POS0:$VIEW_POS1:$VIEW_POS2:$VIEW_POS3:$VIEW_POS4:$VIEW_POS5:$VIEW_POS6:$VIEW_POS7:$VIEW_POS8:$VIEW_POS9:$VIEW_POS10:$VIEW_POS11:$VIEW_POS12:$VIEW_POS13:$VIEW_POS14:$VIEW_POS15"

echo $CONFIG
