#!/usr/bin/env bash

#
# Generic AAC/M4A Encoder Bash Script for macOS
# Copyright (c) 2024 Rodrigo Polo - rodrigopolo.com - The MIT License (MIT)
#

# Modifying the internal field separator
IFS=$'\t\n'

for f in $@; do

	OUTPUT="${f%.*}.aac.m4a"

	ffmpeg \
	-y \
	-hide_banner \
	-i "$f" \
	-vn \
	-ac 1 \
	-c:a aac \
	-b:a 64k \
	-movflags +faststart \
	$OUTPUT

	OUTPUT="${f%.*}.opus.ogg"

	ffmpeg \
	-y \
	-hide_banner \
	-i "$f" \
	-ac 1 \
	-vn \
	-c:a libopus \
	$OUTPUT

done
