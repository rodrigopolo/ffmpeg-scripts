#!/usr/bin/env bash

#
# Cubemap to Equirectangular AVC/H.264 Encoder Bash Script for macOS
# Copyright (c) 2024 Rodrigo Polo - rodrigopolo.com - The MIT License (MIT)
#

# To convert YouTube cubemap format to equirectangular, ej:
# youtube-dl https://youtu.be/Wmdkhmuh-zU -f "136+140" -o Test360.mp4

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

	OUTPUT="${f%.*}.H264.ER.$PRESET.$CRF.mp4"

	# Get video info
	WIDTH=$(mediainfo --Inform="Video;%Width%" "$f")
	HEIGHT=$(( $WIDTH/2 ))

	ffmpeg \
	-y \
	-hide_banner \
	-i "$f" \
	-vf "v360=c3x2:e:cubic:in_forder='lfrdbu':in_frot='000313',scale=${WIDTH}:${HEIGHT},setsar=1:1" \
	-pix_fmt yuv420p \
	-c:v libx264 \
	-preset faster \
	-crf 21 \
	-c:a copy \
	-movflags +faststart \
	$OUTPUT

done
