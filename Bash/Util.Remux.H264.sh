#!/usr/bin/env bash

#
# Generic AVC/H.264 Remux Bash Script for macOS
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

	OUTPUT="${f%.*}.H264.Remux.mp4"
	ffmpeg \
	-y \
	-hide_banner \
	-i "$f" \
	-codec copy \
	-movflags +faststart \
	$OUTPUT

done
