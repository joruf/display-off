#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Install missing system dependencies for Display Off.

Must be executed with root privileges via pkexec or sudo.
"""

import os
import shutil
import subprocess
import sys


def install_dependencies() -> int:
    """
    Detect the package manager and install required dependencies.

    @return int Exit code (0 on success, non-zero on failure)
    """
    if os.geteuid() != 0:
        print("Please run this script as root (sudo/pkexec).", file=sys.stderr)
        return 1

    print("Installing missing dependencies for Display Off...")

    if shutil.which("apt-get"):
        commands = [
            ["apt-get", "update"],
            ["apt-get", "install", "-y", "x11-xserver-utils", "python3-tk"],
        ]
    elif shutil.which("dnf"):
        commands = [
            ["dnf", "install", "-y", "xset", "python3-tkinter"],
        ]
    elif shutil.which("pacman"):
        commands = [
            ["pacman", "-Sy", "--noconfirm", "xorg-xset", "tk"],
        ]
    else:
        print(
            "Unsupported package manager. Please install 'xset' and "
            "'python3-tk' manually.",
            file=sys.stderr,
        )
        return 1

    for command in commands:
        result = subprocess.run(command, check=False)
        if result.returncode != 0:
            return result.returncode

    print("Dependencies successfully installed.")
    return 0


def main() -> None:
    """Entry point for dependency installation."""
    sys.exit(install_dependencies())


if __name__ == "__main__":
    main()
