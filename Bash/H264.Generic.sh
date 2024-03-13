#!/usr/bin/env bash

#
# Generic AVC/H.264 Encoder Bash Script for macOS
# Copyright (c) 2024 Rodrigo Polo - rodrigopolo.com - The MIT License (MIT)
#

#
# Constants
#

# Constant Rate Factor/Quality, between 20 up to 28
CRF=21

# Preset: ultrafast, superfast, veryfast, faster, fast, medium, slow, slower, veryslow, placebo.
PRESET=faster

# Optional filters
# -vf "crop=720:960:0:160,scale=480:640,setsar=1:1" \

# Modifying the internal field separator
IFS=$'\t\n'

for f in $@; do

	OUTPUT="${f%.*}.H264.$PRESET.$CRF.mp4"
	ffmpeg \
	-y \
	-hide_banner \
	-i "$f" \
	-pix_fmt yuv420p \
	-c:v libx264 \
	-preset $PRESET \
	-crf $CRF \
	-c:a aac \
	-b:a 128k \
	-movflags +faststart \
	$OUTPUT

done
