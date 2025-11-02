#!/usr/bin/env python3
import os
import random
import subprocess
import sys
import json
from typing import Any, Dict


def find_wallpapers(wallpaper_dir):
    """
    Finds all image files in a directory and its subdirectories.

    Args:
        wallpaper_dir (str): The path to the main wallpaper directory.

    Returns:
        list: A list of full paths to image files.
    """
    supported_extensions = [".jpg", ".jpeg", ".png", ".bmp", ".gif"]
    wallpaper_files = []
    # os.walk recursively explores the directory tree
    for root, _, files in os.walk(wallpaper_dir):
        for file in files:
            # Check if the file has a supported image extension
            if any(file.lower().endswith(ext) for ext in supported_extensions):
                wallpaper_files.append(os.path.join(root, file))
    return wallpaper_files


def run_command_silently(command):
    """
    Runs a shell command silently and checks for errors.

    Args:
        command (list): The command and its arguments as a list of strings.

    Returns:
        bool: True if the command was successful, False otherwise.
    """
    try:
        # Using subprocess.run to execute external commands.
        # check=True will raise a CalledProcessError if the command returns a non-zero exit code.
        # stdout and stderr are redirected to DEVNULL to suppress all output.
        subprocess.run(
            command, check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL
        )
        return True
    except (FileNotFoundError, subprocess.CalledProcessError):
        # If the command is not found or fails, return False.
        return False


def update_hyprlock_conf(wallpaper_path):
    """
    Updates the 'path' variable in the hyprlock configuration file
    with the absolute path of the new wallpaper.

    Args:
        wallpaper_path (str): The absolute path to the new wallpaper image.
    """
    conf_path = os.path.expanduser("~/.config/hypr/hyprlock.conf")

    # Read the entire configuration file
    with open(conf_path, "r") as f:
        lines = f.readlines()

    new_lines = []

    # Iterate through lines and replace the 'path =' line
    for line in lines:
        stripped_line = line.lstrip()

        # Look for the 'path =' entry within the config file
        if stripped_line.startswith("path ="):
            # Replace the old path with the new, absolute path
            new_path_line = f"    path = {wallpaper_path}\n"
            new_lines.append(new_path_line)
        else:
            new_lines.append(line)

    # Write the modified content back to the file
    with open(conf_path, "w") as f:
        f.writelines(new_lines)


def main():
    """
    Main function to set a random wallpaper and update system colors silently.
    """

    wallpaper_dir = os.path.expanduser("~/wallpaper")

    if not os.path.isdir(wallpaper_dir):
        sys.exit(1)

    all_wallpapers = find_wallpapers(wallpaper_dir)

    if not all_wallpapers:
        sys.exit(1)

    # Select a random wallpaper from the list
    chosen_wallpaper = random.choice(
        all_wallpapers
    )  # --- Step 1: Run sww to set wallpaper since hyprpanel is inconsistent
    run_command_silently(["hyprpanel", "setWallpaper", chosen_wallpaper])
    run_command_silently(["swww", "img", chosen_wallpaper])

    # --- Step 2: Run wal to set colors

    run_command_silently(
        [
            "matugen",
            "image",
            chosen_wallpaper,
            "-t",
            "scheme-content",
            "-m",
            "dark",
            "-s",
            "expressive",
        ]
    )
    # run_command_silently(["wal", "-n", "--cols16", "-i", chosen_wallpaper])

    # --- Step 5: Update hyprlock configuration
    update_hyprlock_conf(chosen_wallpaper)
    sys.exit(0)


if __name__ == "__main__":
    main()
