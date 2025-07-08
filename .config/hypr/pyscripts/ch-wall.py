#!/usr/bin/env python3
import os
import random
import subprocess
import sys

def find_wallpapers(wallpaper_dir):
    """
    Finds all image files in a directory and its subdirectories.

    Args:
        wallpaper_dir (str): The path to the main wallpaper directory.

    Returns:
        list: A list of full paths to image files.
    """
    supported_extensions = ['.jpg', '.jpeg', '.png', '.bmp', '.gif']
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
            command,
            check=True,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL
        )
        return True
    except (FileNotFoundError, subprocess.CalledProcessError):
        # If the command is not found or fails, return False.
        return False


def main():
    """
    Main function to set a random wallpaper and update system colors silently.
    """
    # os.path.expanduser expands the '~' to the full home directory path
    wallpaper_dir = os.path.expanduser('~/wallpaper')

    if not os.path.isdir(wallpaper_dir):
        sys.exit(1)

    all_wallpapers = find_wallpapers(wallpaper_dir)

    if not all_wallpapers:
        sys.exit(1)

    # Select a random wallpaper from the list
    chosen_wallpaper = random.choice(all_wallpapers)

    # --- Step 1: Set the wallpaper using hyprpanel ---
    if not run_command_silently(['hyprpanel', 'setWallpaper', chosen_wallpaper]):
        sys.exit(1)

    # --- Step 2: Run wal to generate and apply a new color scheme ---
    if not run_command_silently(['wal', '-q', '-i', chosen_wallpaper]):
        sys.exit(1)


if __name__ == '__main__':
    main()
