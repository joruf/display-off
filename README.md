# Display Off

A lightweight, efficient shell script utility for Linux that instantly forces your display into sleep mode via DPMS (Display Power Management Signaling). The display remains off until you move the mouse or press any key.

---

## Features

* **Instant Display Sleep:** Forces the screen off immediately without waiting for system idle timers.
* **Zero-Configuration Setup:** Automatically detects your desktop environment on the first run.
* **Localized Desktop Support:** Dynamically locates your desktop folder, even if it is named something other than "Desktop" (e.g., `Schreibtisch`, `Bureau`, etc.).
* **First-Run Integration:** Prompts you via a graphical dialog (`zenity`) to create a convenient desktop shortcut upon its first execution.

---

## How It Works

The project is split into two modular scripts to keep runtime performance decoupled from the initial installation:

1. **`DisplayOff.sh` (Main Executable):** This is the script you interact with. On execution, it checks for a hidden file named `.displayoff_initialized` in its own directory. If the file is missing, it automatically launches the setup process. Once initialization is cleared, it exports the default display environment (`DISPLAY=:0`) and triggers `xset dpms force off`.
2. **`setup-shortcut.sh` (Installer):** Triggered only during the first run. It opens a graphical `zenity` prompt asking if you want a desktop shortcut. If confirmed, it dynamically finds your localized desktop directory via `xdg-user-dir DESKTOP` and generates a compliant Linux `.desktop` application launcher pointing directly back to your local script path and icon.

---

## Requirements

Ensure you have `xset` (usually pre-installed with X11) and `zenity` (for the graphical dialog) installed on your system.

---

## Installation & Usage

Open your terminal, navigate to the folder where the scripts are stored, and grant execution permissions to all three files:
```bash
git clone https://github.com/joruf/desktop-off.git
cd desktop-off
chmod +x DisplayOff.sh setup-requirements.sh setup-shortcut.sh
./DesktopOff.sh

```
