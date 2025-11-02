#!/bin/bash

# This script runs AFTER swww successfully sets a new wallpaper.
# The image path for the currently set wallpaper can be retrieved with swww query.

# 1. Grab the path for the first displayed image using the logic from before.
#    We assume all monitors use the same image, or we only care about the first one.
IMAGE_PATH=$(swww query | grep -oP 'image: \K.*' | head -n 1)

# Check if a path was successfully extracted
if [ -n "$IMAGE_PATH" ]; then
    # 2. Use hyprpanel to set the wallpaper using the extracted path.
    #    The quotes around $IMAGE_PATH are essential for paths with spaces or special characters.
    hyprpanel setWallpaper "$IMAGE_PATH"
else
    # Log an error if the path couldn't be found
    echo "Error: Could not retrieve image path from swww query." >> /tmp/hyprpanel_swww_hook.log
fi
