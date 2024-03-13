#!/usr/bin/env bash

#
# Twitter AVC/H.264 Encoder Bash Script for macOS
# Copyright (c) 2024 Rodrigo Polo - rodrigopolo.com - The MIT License (MIT)
#

#
# Constants
#

# Constant Rate Factor/Quality, between 20 up to 28
CRF=24

# Preset: ultrafast, superfast, veryfast, faster, fast, medium, slow, slower, veryslow, placebo.
PRESET=faster

# Modifying the internal field separator
IFS=$'\t\n'

for f in $@; do

	OUTPUT="${f%.*}.Twitter.H264.$PRESET.$CRF.mp4"
	ffmpeg \
	-y \
	-hide_banner \
	-i "$f" \
	-pix_fmt yuv420p \
	-vf "scale=1280:-2" \
	-c:v libx264 \
	-preset $PRESET \
	-crf $CRF \
	-c:a aac \
	-b:a 128k \
	-movflags +faststart \
	-t 140 \
	$OUTPUT

done
