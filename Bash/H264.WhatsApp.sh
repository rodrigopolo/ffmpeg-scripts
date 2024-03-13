#!/usr/bin/env bash

#
# Generic WhatsApp/AVC/H.264 Encoder Bash Script for  macOS
# Copyright (c) 2024 Rodrigo Polo - rodrigopolo.com - The MIT License (MIT)
#

# Video sizes using a 16:9 aspect ratio:
#   256:144
#   426:240
#   640:360
#   854:480
#   1280:720
#   1920:1080
#   2560:1440
#   3840:2160

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

	OUTPUT="${f%.*}.wz.$PRESET.$CRF.mp4"
	ffmpeg \
	-y \
	-hide_banner \
	-i "$f" \
	-pix_fmt yuv420p \
	-vf "scale=640:-2" \
	-c:v libx264 \
	-preset $PRESET \
	-crf $CRF \
	-c:a aac \
	-b:a 48k \
	-ar 44100 \
	-ac 1 \
	-movflags +faststart \
	$OUTPUT

done
