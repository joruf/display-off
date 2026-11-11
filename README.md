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

## Executable

A single-file Linux executable (x86_64, built on Ubuntu 22.04, runs on the same or a newer glibc) is published on the [Releases page](https://github.com/joruf/display-off/releases). Download `display-off-linux-x86_64-<version>-build<build>`, make it executable (`chmod +x`) and start it. `--version` prints its version.

It turns the display off through `xset` (package `x11-xserver-utils`) on X11. If `xset` is missing, the executable says so and stops instead of installing it. The first-run offer for a desktop shortcut is skipped in the executable.

Build it yourself from a full clone (the version is counted from the commit history):

```bash
sudo apt install python3-venv python3-tk
./build-exe.py            # --clean rebuilds the build environment, --keep-env reuses it
```

The result is `dist/display-off-linux-x86_64-<version>-build<build>`. The GitHub Actions workflow `release-exe.yml` does the same on every push to `main` and publishes the file as the release `v<version>-build<build>`.
