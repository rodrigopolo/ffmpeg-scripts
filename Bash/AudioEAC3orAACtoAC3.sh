#!/usr/bin/env bash

#
# Generic EAC3 or AAC to AC3 Encoder Bash Script for macOS
# Copyright (c) 2024 Rodrigo Polo - rodrigopolo.com - The MIT License (MIT)
#

# Modifying the internal field separator
IFS=$'\t\n'

for f in $@; do

	OUTPUT="${f%.*}.ac3"

	ffmpeg \
	-y \
	-hide_banner \
	-hwaccel auto \
	-i "$f" \
	-vn \
	-c:a ac3 \
	-b:a 640k \
	$OUTPUT

done

