#!/usr/bin/env bash

#
# Mediainfo Bash Script for macOS
# Copyright (c) 2024 Rodrigo Polo - rodrigopolo.com - The MIT License (MIT)
#

#
# Constants
#

# This script file path
THIS_PATH="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Bin/executable file path
BIN_PATH=$THIS_PATH/bin

# Modifying the internal field separator
IFS=$'\t\n'

mediainfo -f -Lang=raw --ReadByHuman=0 --Output=XML "$@"

