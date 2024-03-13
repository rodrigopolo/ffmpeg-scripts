#!/usr/bin/env bash

#
# Video+SRT to AVC/H.264 Video Burned Subs Bash Script for macOS
# Copyright (c) 2024 Rodrigo Polo - rodrigopolo.com - The MIT License (MIT)
#

#
# Constants
#

# Constant Rate Factor/Quality, between 20 up to 28
CRF=21

# Preset: ultrafast, superfast, veryfast, faster, fast, medium, slow, slower, veryslow, placebo.
PRESET=faster

# Sub font size
FONT_SIZE=26

# Hex colors
WHITE=ffffff
BLACK=000000
YELLOW=00ffff

# Font and outline colors
FONT_COLOR=$YELLOW
OUTLINE_COLOUR=$BLACK

# This script file path
THIS_PATH="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Bin/executable file path
BIN_PATH=$THIS_PATH/bin

# Modifying the internal field separator
IFS=$'\t\n'

for f in $@; do

	# Input and output paths
	SOURCE=$($BIN_PATH/real_path.sh $f)
	SOURCE_NOEXT="${f%.*}"
	INPUTSRT="${SOURCE_NOEXT}.srt"
	OUTPUT="${SOURCE_NOEXT}.H264Sub.$PRESET.$CRF.mp4"

	# Get video info
	DURATION=$(mediainfo --Inform="General;%Duration/String3%" "$f")
	WIDTH=$(mediainfo --Inform="Video;%Width%" "$f")
	HEIGHT=$(mediainfo --Inform="Video;%Height%" "$f")
	FPS=$(mediainfo --Inform="Video;%FrameRate%" "$f")

	ffmpeg \
	-y \
	-hide_banner \
	-i "$f" \
	-pix_fmt yuv420p \
	-vf "subtitles=${INPUTSRT}:force_style='Fontsize=${FONT_SIZE},PrimaryColour=&H${FONT_COLOR},OutlineColour=&H${OUTLINE_COLOUR},Shadow=1'" \
	-c:v libx264 \
	-preset $PRESET \
	-crf $CRF \
	-c:a aac \
	-b:a 128k \
	-movflags +faststart \
	$OUTPUT

done
