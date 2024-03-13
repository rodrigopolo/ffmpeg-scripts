#!/usr/bin/env bash

#
# SRT to AVC/H.264 Chroma Video Bash Script for macOS
# Copyright (c) 2024 Rodrigo Polo - rodrigopolo.com - The MIT License (MIT)
#

#
# Constants
#

# Constant Rate Factor/Quality, between 20 up to 28
CRF=20

# Preset: ultrafast, superfast, veryfast, faster, fast, medium, slow, slower, veryslow, placebo.
PRESET=fast

# Sub font size
FONT_SIZE=26

# Hex colors
WHITE=ffffff
BLACK=000000
YELLOW=00ffff

# Font and outline colors
FONT_COLOR=$YELLOW
OUTLINE_COLOUR=$BLACK

# Background color
# Red, Lime, Blue, Aqua, Fuchsia, Yellow
# https://ffmpeg.org/ffmpeg-all.html#Color
BG_COLOR=blue

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
	OUTPUT="${SOURCE_NOEXT}.BlueSub.$PRESET.$CRF.mp4"

	# Get video info
	DURATION=$(mediainfo --Inform="General;%Duration/String3%" "$f")
	WIDTH=$(mediainfo --Inform="Video;%Width%" "$f")
	HEIGHT=$(mediainfo --Inform="Video;%Height%" "$f")
	FPS=$(mediainfo --Inform="Video;%FrameRate%" "$f")

	ffmpeg \
	-y \
	-hide_banner \
	-f lavfi \
	-i "color=c=${BG_COLOR}:s=${WIDTH}x${HEIGHT}" \
	-r "$FPS" \
	-vf "subtitles=${INPUTSRT}:force_style='Fontsize=${FONT_SIZE},PrimaryColour=&H${FONT_COLOR},OutlineColour=&H${OUTLINE_COLOUR},Shadow=1'" \
	-pix_fmt yuv420p \
	-c:v libx264 \
	-preset $PRESET \
	-crf $CRF \
	-an \
	-t "$DURATION" \
	-movflags +faststart \
	$OUTPUT

done
