#!/usr/bin/env bash

#
# Generic ALAC/M4A Encoder Bash Script for macOS
# Copyright (c) 2024 Rodrigo Polo - rodrigopolo.com - The MIT License (MIT)
#

# Modifying the internal field separator
IFS=$'\t\n'

for f in $@; do

	OUTPUT="${f%.*}.alac.m4a"

	ffmpeg \
	-y \
	-hide_banner \
	-i "$f" \
	-vn \
	-c:a alac \
	-movflags +faststart \
	$OUTPUT

done
