#!/usr/bin/env bash

#
# Generic 4K-DCI Cinemascope crop, to UHD crop, HEVC/H.265 Encoder Bash Script for macOS
# Copyright (c) 2024 Rodrigo Polo - rodrigopolo.com - The MIT License (MIT)
#

#
# Constants
#

# Constant Rate Factor/Quality, between 18 up to 51, 28 in H.265 = 23 in H.264
CRF=22

# Preset: ultrafast, superfast, veryfast, faster, fast, medium, slow, slower, veryslow, placebo.
PRESET=superfast

# Modifying the internal field separator
IFS=$'\t\n'

for f in $@; do

	OUTPUT="${f%.*}.UHDCrop.H265.$PRESET.$CRF.CS.mp4"
	ffmpeg \
	-y \
	-hide_banner \
	-i "$f" \
	-vf "crop=4096:1708:0:226,scale=3840:1600" \
	-pix_fmt yuv420p \
	-c:v libx265 \
	-tag:v hvc1 \
	-preset $PRESET \
	-crf $CRF \
	-c:a aac \
	-b:a 128k \
	-movflags +faststart \
	$OUTPUT

done
