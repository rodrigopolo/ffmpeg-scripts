#!/usr/bin/env bash

#
# Modify Rotate Metadata Bash Script for macOS
# Copyright (c) 2024 Rodrigo Polo - rodrigopolo.com - The MIT License (MIT)
#

#
# Constants
#

# Rotation:
#   0 =   0 Rotation, no rotation metadata
#  90 =  90 Counter Clockwise
# -90 =  90 Clockwise
# 180 = 180 Clockwise

# Constant Rate Factor/Quality, between 20 up to 28
ROTATION=0

# Modifying the internal field separator
IFS=$'\t\n'

for f in $@; do

	OUTPUT="${f%.*}.H264.${ROTATION}Deg.mp4"
	ffmpeg \
	-y \
	-hide_banner \
	-i "$f" \
	-codec copy \
	-map_metadata 0 \
	-metadata:s:v:0 rotate=${ROTATION} \
	-movflags +faststart \
	$OUTPUT

done
