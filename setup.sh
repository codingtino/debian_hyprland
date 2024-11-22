#!/bin/bash

######################################################################
# Title: Debian Hyprland                                             #
# Author: Tino Naumann                                               #
# Repository: https://github.com/codingtino/debian_hyprland          #
######################################################################

set -euo pipefail

CALLER_DIR="$(pwd)"
WORKING_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


echo "Installing Dependencies"
source "$WORKING_DIR/setup/dependencies.sh"







