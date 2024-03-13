#!/usr/bin/env bash

#
# Thumbnail Generator Bash Script for macOS
# Copyright (c) 2024 Rodrigo Polo - rodrigopolo.com - The MIT License (MIT)
#

#
# Constants
#

# Number of thumbnails
THUMBNAIL_NO=10

# Modifying the internal field separator
IFS=$'\t\n'

for f in $@; do

	OUTPUT="${f%.*}.th%04d.png"
	DURATION=$(mediainfo --Inform="General;%Duration%" "$f")

	ffmpeg \
	-i "$f" \
	-y \
	-hide_banner \
	-vf "fps=${THUMBNAIL_NO}000/${DURATION}" \
	$OUTPUT

done
