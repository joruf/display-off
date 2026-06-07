#!/bin/bash

# Determine paths relative to the script location
SCRIPT_PATH="$(realpath "$0")"
SCRIPT_DIR="$(dirname "$SCRIPT_PATH")"
CONFIG_FILE="$SCRIPT_DIR/.displayoff_initialized"
SETUP_SCRIPT="$SCRIPT_DIR/setup-shortcut.sh"

# 1. First-time setup logic
if [ ! -f "$CONFIG_FILE" ]; then
    if [ -x "$SETUP_SCRIPT" ]; then
        bash "$SETUP_SCRIPT"
    else
        echo "Error: setup.sh not found or not executable!" >&2
    fi
    
    # Keep the configuration flag in the script directory
    touch "$CONFIG_FILE"
fi

# 2. Turn off the display
export DISPLAY=:0
xset dpms force off
