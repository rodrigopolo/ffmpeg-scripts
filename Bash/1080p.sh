#!/usr/bin/env bash

#
# Generic AVC/H.264 1080p Encoder Bash Script for macOS
# Copyright (c) 2024 Rodrigo Polo - rodrigopolo.com - The MIT License (MIT)
#

#
# Constants
#

# Constant Rate Factor/Quality, between 20 up to 28
CRF=22

# Preset: ultrafast, superfast, veryfast, faster, fast, medium, slow, slower, veryslow, placebo.
PRESET=faster

# Modifying the internal field separator
IFS=$'\t\n'

for f in $@; do

	OUTPUT="${f%.*}.1080p.H264.$PRESET.$CRF.mp4"
	ffmpeg \
	-y \
	-hide_banner \
	-hwaccel auto \
	-i "$f" \
	-pix_fmt yuv420p \
	-vf "scale=1920:-2" \
	-c:v libx264 \
	-preset $PRESET \
	-crf $CRF \
	-c:a aac \
	-b:a 128k \
	-movflags +faststart \
	$OUTPUT

done
