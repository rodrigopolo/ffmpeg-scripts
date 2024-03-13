#!/usr/bin/env bash

#
# Generic PCM Encoder Bash Script for macOS
# Copyright (c) 2024 Rodrigo Polo - rodrigopolo.com - The MIT License (MIT)
#

# PCM Codecs:
#   Adobe Audition
#     pcm_u8    = PCM unsigned 8-bit
#     pcm_s16le = PCM signed 16-bit little-endian
#     pcm_s24le = PCM signed 24-bit little-endian
#     pcm_f32le = PCM 32-bit floating-point little-endian
#   Canon EOS R5
#     pcm_s16be = PCM signed 16-bit big-endian
#     AAC 256Kbps
#   Atomos Ninja V
#     pcm_s24le = PCM signed 24-bit little-endian

# Modifying the internal field separator
IFS=$'\t\n'

for f in $@; do

	OUTPUT="${f%.*}.pcm.wav"

	ffmpeg \
	-y \
	-hide_banner \
	-i "$f" \
	-vn \
	-ar 16000 \
	-ac 1 \
	-c:a pcm_s16le \
	$OUTPUT

done
