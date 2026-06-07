#!/bin/bash

# Determine paths relative to the script location
SCRIPT_PATH="$(realpath "$0")"
SCRIPT_DIR="$(dirname "$SCRIPT_PATH")"
CONFIG_FILE="$SCRIPT_DIR/.displayoff_initialized"
REQUIREMENTS_SCRIPT="$SCRIPT_DIR/setup-requirements.sh"
SHORTCUT_SCRIPT="$SCRIPT_DIR/setup-shortcut.sh"

# 1. Check and install missing requirements first
if ! command -v xset >/dev/null 2>&1 || ! command -v zenity >/dev/null 2>&1; then
    if [ -x "$REQUIREMENTS_SCRIPT" ]; then
        # Try to run with graphical sudo (pkexec), fallback to standard sudo
        if command -v pkexec >/dev/null 2>&1; then
            pkexec bash "$REQUIREMENTS_SCRIPT"
        else
            sudo bash "$REQUIREMENTS_SCRIPT"
        fi
    else
        echo "Error: setup-requirements.sh not found or not executable!" >&2
        exit 1
    fi
fi

# 2. First-time shortcut setup logic
if [ ! -f "$CONFIG_FILE" ]; then
    if [ -x "$SHORTCUT_SCRIPT" ]; then
        bash "$SHORTCUT_SCRIPT"
    else
        echo "Error: setup-shortcut.sh not found or not executable!" >&2
    fi
    
    # Keep the configuration flag in the script directory
    touch "$CONFIG_FILE"
fi

# 3. Turn off the display
export DISPLAY=:0
xset dpms force off
