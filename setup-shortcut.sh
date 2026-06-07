#!/bin/bash

# Determine paths relative to the script location
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
DISPLAY_OFF_SCRIPT="$SCRIPT_DIR/DisplayOff.sh"

# Dynamically resolve the real, localized desktop path (e.g., Desktop, Schreibtisch, etc.)
DESKTOP_DIR="$(xdg-user-dir DESKTOP)"
DESKTOP_FILE="$DESKTOP_DIR/DisplayOff.desktop"

# Graphical confirmation dialog via Zenity
if zenity --question --text="Do you want to create a desktop shortcut for 'Display Off'?" --title="First-time Setup" --width=300; then
    
    # Generate the Desktop Entry file
    cat <<EOF > "$DESKTOP_FILE"
[Desktop Entry]
Type=Application
Name=Display Off
Comment=Turn off the display until mouse or keyboard input
Exec=$DISPLAY_OFF_SCRIPT
Icon=display
Terminal=false
Categories=Utility;
EOF

    # Make the desktop shortcut executable
    chmod +x "$DESKTOP_FILE"
    
    # Brief graphical confirmation (auto-closes after 2 seconds)
    zenity --info --text="Shortcut successfully created on your desktop ($DESKTOP_DIR)." --title="Success" --timeout=2
fi
