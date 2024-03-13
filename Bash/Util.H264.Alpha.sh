#!/usr/bin/env bash

#
# OBS Overlay RGBA QTRLE Encoder Batch Script for macOS
# Copyright (c) 2024 Rodrigo Polo - rodrigopolo.com - The MIT License (MIT)
#

#
# Constants
#

# Constant Rate Factor/Quality, between 20 up to 28
CRF=21

# Preset: ultrafast, superfast, veryfast, faster, fast, medium, slow, slower, veryslow, placebo.
PRESET=faster


# Modifying the internal field separator
IFS=$'\t\n'

for f in $@; do

	OUTPUT="${f%.*}.OBSTransNS.mov"
	ffmpeg \
	-y \
	-hide_banner \
	-fflags +genpts \
	-i "$f" \
	-pix_fmt rgba \
	-c:v libx264rgb \
	-preset $PRESET \
	-crf $CRF \
	-an \
	-movflags +faststart \
	$OUTPUT

done





