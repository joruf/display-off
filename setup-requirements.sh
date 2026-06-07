#!/bin/bash

# Ensure the script is running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root (sudo/pkexec)." >&2
    exit 1
fi

echo "Installing missing dependencies for Display Off..."

# Detect package manager and install requirements
if command -v apt-get >/dev/null 2>&1; then
    apt-get update
    apt-get install -y x11-xserver-utils zenity
elif command -v dnf >/dev/null 2>&1; then
    dnf install -y xset zenity
elif command -v pacman >/dev/null 2>&1; then
    pacman -Sy --noconfirm xorg-xset zenity
else
    echo "Unsupported package manager. Please install 'xset' and 'zenity' manually." >&2
    exit 1
fi

echo "Dependencies successfully installed."
