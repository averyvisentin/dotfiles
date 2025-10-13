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


def convert_pywal_to_vicinae(pywal_path: str, output_path: str) -> bool:
    """
    Convert a Pywal colors.json file to a Vicinae-compatible theme.

    This function attempts the conversion silently, returning True on success
    and False on any failure (file not found, bad JSON, missing key).

    Args:
        pywal_path (str): Path to the Pywal `colors.json` file.
        output_path (str): Destination file path for the Vicinae theme JSON.

    Returns:
        bool: True if conversion was successful, False otherwise.
    """
    try:
        # Ensure paths are expanded for ~ (home directory)
        pywal_path = os.path.expanduser(pywal_path)
        output_path = os.path.expanduser(output_path)

        # Load Pywal color definitions
        with open(pywal_path, "r", encoding="utf-8") as f:
            pywal: Dict[str, Any] = json.load(f)

        # Map Pywal colors to Vicinae theme format
        vicinae_theme: Dict[str, Any] = {
            "version": "1.0.0",
            "appearance": "dark",
            "icon": "",
            "name": "Pywal",
            "description": "Automatically generated from Pywal",
            "palette": {
                "background": pywal["special"]["background"],
                "foreground": pywal["special"]["foreground"],
                "blue": pywal["colors"]["color4"],
                "green": pywal["colors"]["color2"],
                "magenta": pywal["colors"]["color5"],
                "orange": pywal["colors"]["color11"],
                "purple": pywal["colors"]["color13"],
                "red": pywal["colors"]["color1"],
                "yellow": pywal["colors"]["color3"],
                "cyan": pywal["colors"]["color6"],
            },
        }

        # Ensure output directory exists
        os.makedirs(os.path.dirname(output_path), exist_ok=True)

        # Write theme file (overwrites if already exists)
        with open(output_path, "w", encoding="utf-8") as f:
            json.dump(vicinae_theme, f, indent=2)

        # Success - no output
        return True

    except (FileNotFoundError, KeyError, json.JSONDecodeError, Exception):
        # Failures are handled silently
        return False


def main():
    """
    Main function to set a random wallpaper and update system colors silently.
    """
    # os.path.expanduser expands the '~' to the full home directory path
    pywal_file = "~/.cache/wal/colors.json"
    vicinae_theme_file = "~/dotfiles/.config/vicinae/themes/pywal-theme.json"
    wallpaper_dir = os.path.expanduser("~/wallpaper")

    if not os.path.isdir(wallpaper_dir):
        sys.exit(1)

    all_wallpapers = find_wallpapers(wallpaper_dir)

    if not all_wallpapers:
        sys.exit(1)

    # Select a random wallpaper from the list
    chosen_wallpaper = random.choice(all_wallpapers)

    # --- Step 1: Generate matugen and pywal colors using hyprpanel ---
    # if not run_command_silently(['hyprpanel', 'setWallpaper', chosen_wallpaper]):
    #    sys.exit(1)

    # --- Step 2: Run sww to set wallpaper since hyprpanel is inconsistent
    if not run_command_silently(["swww", "img", chosen_wallpaper]):
        sys.exit(1)

    if not run_command_silently(["wal", "-i", chosen_wallpaper, "-n", "--cols16"]):
        sys.exit(1)

    if not convert_pywal_to_vicinae(pywal_file, vicinae_theme_file):
        # Exit with a non-zero status code if conversion failed
        sys.exit(1)

    if not run_command_silently(["vicinae", "'vicinae://theme/set/pywal-theme.json'"]):
        sys.exit(1)

    update_hyprlock_conf(chosen_wallpaper)


if __name__ == "__main__":
    main()
