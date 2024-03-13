#!/usr/bin/env bash

#
# Generic OPUS/OGG Encoder Bash Script for macOS
# Copyright (c) 2024 Rodrigo Polo - rodrigopolo.com - The MIT License (MIT)
#

# Modifying the internal field separator
IFS=$'\t\n'

for f in $@; do

	OUTPUT="${f%.*}.opus.ogg"

	ffmpeg \
	-y \
	-hide_banner \
	-i "$f" \
	-vn \
	-c:a libopus \
	$OUTPUT

done
