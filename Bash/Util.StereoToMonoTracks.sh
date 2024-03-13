#!/usr/bin/env bash

#
# Generic AAC/M4A Encoder Bash Script for macOS
# Copyright (c) 2024 Rodrigo Polo - rodrigopolo.com - The MIT License (MIT)
#

# Modifying the internal field separator
IFS=$'\t\n'

for f in $@; do

	ffmpeg \
	-i "$f" \
	-map_channel 0.0.0 "${f%.*}.l.aac.m4a" \
	-map_channel 0.0.1 "${f%.*}.r.aac.m4a"

done
