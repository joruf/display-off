# Display Off

A lightweight Python utility for Linux that instantly forces your display into sleep mode via DPMS (Display Power Management Signaling). The display remains off until you move the mouse or press any key.

---

## Features

* **Instant Display Sleep:** Forces the screen off immediately without waiting for system idle timers.
* **Zero-Configuration Setup:** Automatically installs missing dependencies on the first run.
* **Localized Desktop Support:** Dynamically locates your desktop folder, even if it is named something other than "Desktop" (e.g., `Schreibtisch`, `Bureau`, etc.).
* **First-Run Integration:** Prompts you via a graphical dialog on first run whether to create a desktop shortcut, following the same setup flow as [Mint Cleaner](https://github.com/joruf/mint-cleaner) and [Shredder](https://github.com/joruf/shredder).

---

## How It Works

1. **`display_off.py` (Main Executable):** Ensures `xset` is installed, runs the first-run desktop shortcut setup, then triggers `xset dpms force off` with `DISPLAY=:0`.
2. **`desktop_setup.py` (Desktop Shortcut Setup):** Prompts only once whether a desktop shortcut should be created. The `.initialized` marker file in the project directory ensures the dialog is not shown again.
3. **`setup_requirements.py` (Dependency Installer):** Installs `xset` and `python3-tk` via the detected package manager when run with root privileges.

---

## Requirements

* Python 3.6+ with `tkinter` (usually pre-installed)
* `xset` from `x11-xserver-utils` (installed automatically when missing)

---

## Installation & Usage

```bash
git clone https://github.com/joruf/display-off.git
cd display-off
chmod +x display_off.py setup_requirements.py desktop_setup.py
python3 display_off.py
```
