#!/usr/bin/env bash

#
# OBS Overlay RGBA QTRLE Encoder Batch Script for macOS
# Copyright (c) 2024 Rodrigo Polo - rodrigopolo.com - The MIT License (MIT)
#

#
# Constants
#

# Modifying the internal field separator
IFS=$'\t\n'

for f in $@; do

	OUTPUT="${f%.*}.OBSTransNS.mov"
	ffmpeg \
	-y \
	-hide_banner \
	-fflags +genpts \
	-i "$f" \
	-pix_fmt argb \
	-c:v qtrle \
	-an \
	-movflags +faststart \
	$OUTPUT

done

