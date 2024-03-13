#!/usr/bin/env bash

#
# Generic OPUS/OGG Mono Encoder Bash Script for macOS
# Copyright (c) 2024 Rodrigo Polo - rodrigopolo.com - The MIT License (MIT)
#

# Modifying the internal field separator
IFS=$'\t\n'

for f in $@; do

	OUTPUT="${f%.*}.opus.mono.ogg"

	ffmpeg \
	-y \
	-hide_banner \
	-i "$f" \
	-vn \
	-ac 1 \
	-c:a libopus \
	$OUTPUT

done
