#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Instantly turn off the display via DPMS until mouse or keyboard input.

On first run the user is asked once whether a desktop shortcut should be
created. A single .initialized marker file in the project directory tracks
that the prompt has already been shown.
"""

import os
import shutil
import subprocess
import sys
from pathlib import Path

SCRIPT_DIR = Path(__file__).resolve().parent
SETUP_REQUIREMENTS_SCRIPT = SCRIPT_DIR / "setup_requirements.py"


def command_exists(command: str) -> bool:
    """
    Check whether a command is available on PATH.

    @param command str Command name to look up
    @return bool True when the command exists
    """
    return shutil.which(command) is not None


def ensure_requirements() -> None:
    """
    Ensure xset is available, installing dependencies with root if needed.

    @return None
    """
    if command_exists("xset"):
        return

    if not SETUP_REQUIREMENTS_SCRIPT.is_file():
        print("Error: setup_requirements.py not found!", file=sys.stderr)
        sys.exit(1)

    runners = []
    if command_exists("pkexec"):
        runners.append(["pkexec", "python3", str(SETUP_REQUIREMENTS_SCRIPT)])
    runners.append(["sudo", "python3", str(SETUP_REQUIREMENTS_SCRIPT)])

    for command in runners:
        result = subprocess.run(command, check=False)
        if result.returncode == 0 and command_exists("xset"):
            return

    print("Error: Could not install required dependencies.", file=sys.stderr)
    sys.exit(1)


def turn_off_display() -> None:
    """
    Force the display off using xset DPMS.

    @return None
    """
    env = os.environ.copy()
    env.setdefault("DISPLAY", ":0")
    subprocess.run(["xset", "dpms", "force", "off"], check=True, env=env)


def main() -> None:
    """Run dependency checks, first-run setup, and turn off the display."""
    ensure_requirements()

    import tkinter as tk

    from desktop_setup import maybe_prompt_desktop_setup

    root = tk.Tk()
    root.withdraw()
    maybe_prompt_desktop_setup(root)
    root.destroy()

    turn_off_display()


if __name__ == "__main__":
    main()
