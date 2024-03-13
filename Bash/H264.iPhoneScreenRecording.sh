#!/usr/bin/env bash

#
# Generic iPhone vertical screen recording Encoder Bash Script for  macOS
# Copyright (c) 2024 Rodrigo Polo - rodrigopolo.com - The MIT License (MIT)
#

# Video sizes using a 9:16 aspect ratio:
#    144:256
#    240:426
#    360:640
#    480:854
#    720:1280
#   1080:1920
#   1440:2560
#   2160:3840

#
# Constants
#

# Constant Rate Factor/Quality, between 20 up to 28
CRF=26

# Preset: ultrafast, superfast, veryfast, faster, fast, medium, slow, slower, veryslow, placebo.
PRESET=fast

# Modifying the internal field separator
IFS=$'\t\n'

for f in $@; do

	OUTPUT="${f%.*}.iphone.$PRESET.$CRF.mp4"
	ffmpeg \
	-y \
	-hide_banner \
	-i "$f" \
	-pix_fmt yuv420p \
	-vf "scale=-2:480" \
	-c:v libx264 \
	-preset $PRESET \
	-crf $CRF \
	-c:a aac \
	-b:a 64k \
	-ar 44100 \
	-ac 1 \
	-movflags +faststart \
	$OUTPUT

done
