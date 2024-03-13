#!/usr/bin/env bash

#
# Generic AC3 to AAC Encoder Bash Script for macOS
# Copyright (c) 2024 Rodrigo Polo - rodrigopolo.com - The MIT License (MIT)
#

# Modifying the internal field separator
IFS=$'\t\n'

for f in $@; do

	OUTPUT="${f%.*}.aac"

	ffmpeg \
	-hwaccel auto \
	-y \
	-hide_banner \
	-i "$f" \
	-channel_layout "5.1" \
	-vn \
	-c:a aac \
	-b:a 384k \
	-movflags +faststart \
	$OUTPUT

done
