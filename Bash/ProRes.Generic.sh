#!/usr/bin/env bash

#
# Generic ProRes Encoder Bash Script for macOS
# Copyright (c) 2024 Rodrigo Polo - rodrigopolo.com - The MIT License (MIT)
#

#
# Constants
#

# Profile
PROFILE=3

# Profiles:
# -1 = auto (default)
#  0 = proxy    ≈ 45Mbps  YUV    4:2:2
#  1 = lt       ≈ 102Mbps YUV    4:2:2
#  2 = standard ≈ 147Mbps YUV    4:2:2
#  3 = hq       ≈ 220Mbps YUV    4:2:2
#  4 = 4444     ≈ 330Mbps YUVA 4:4:4:4
#  5 = 4444xq   ≈ 500Mbps YUVA 4:4:4:4

# -vf yadif \

# Modifying the internal field separator
IFS=$'\t\n'

for f in $@; do

	OUTPUT="${f%.*}.ProRes.$PRESET.$CRF.mov"
	ffmpeg \
	-y \
	-hide_banner \
	-i "$f" \
	-pix_fmt yuv422p10le \
	-c:v prores_ks \
	-profile:v $PROFILE \
	-vendor apl0 \
	-c:a pcm_s16le \
	$OUTPUT

done
