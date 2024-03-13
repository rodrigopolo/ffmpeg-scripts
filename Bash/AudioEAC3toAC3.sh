#!/usr/bin/env bash

#
# Generic AAC/M4A Encoder Bash Script for macOS
# Copyright (c) 2024 Rodrigo Polo - rodrigopolo.com - The MIT License (MIT)
#

# Modifying the internal field separator
IFS=$'\t\n'

for f in $@; do

	OUTPUT="${f%.*}.ac3"

	ffmpeg \
	-y \
	-hide_banner \
	-i "$f" \
	-channel_layout "5.1" \
	-vn \
	-c:a ac3 \
	-b:a 448k \
	$OUTPUT

done
