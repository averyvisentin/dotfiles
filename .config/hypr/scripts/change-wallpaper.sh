#!/bin/bash

# This script finds a random image from the wallpaper directory (and its subdirectories)
# and sets it as the wallpaper using the 'hyprpanel setWallpaper' command.
# This version uses a more robust method to handle all possible filenames.

# --- 1. Define Wallpaper Directory ---
WALLPAPER_DIR="$HOME/wallpaper"

# --- 2. Check if Directory Exists ---
if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "Error: Wallpaper directory not found at '$WALLPAPER_DIR'"
    exit 1
fi

# --- 3. Find a Random Image File (Robust Method) ---
# -print0 separates filenames with a null character, which is safe for ALL filenames.
# shuf -z reads null-separated input and -n 1 picks one.
# read -r -d '' reads the null-terminated output from shuf into the variable.
RANDOM_WALLPAPER=""
read -r -d '' RANDOM_WALLPAPER < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.bmp" -o -iname "*.webp" \) -print0 | shuf -n 1 -z)


# --- 4. Check if a Wallpaper Was Found ---
if [ -z "$RANDOM_WALLPAPER" ]; then
    echo "Error: No images found in '$WALLPAPER_DIR' or its subdirectories."
    echo "Debug Tip: Run the following command in your terminal to see if it lists any files:"
    echo "find \"$WALLPAPER_DIR\" -type f -iname \"*.jpg\""
    exit 1
fi

echo "Setting new wallpaper: $RANDOM_WALLPAPER"

# --- 5. Execute the hyprpanel Command ---
hyprpanel setWallpaper "$RANDOM_WALLPAPER"

# Check the exit status of the hyprpanel command
if [ $? -ne 0 ]; then
    echo "Warning: 'hyprpanel' command failed or was not found in your PATH."
fi

# --- 6. Execute pywal ---
echo ":: Executing pywal with $RANDOM_WALLPAPER"
wal -q -i "$RANDOM_WALLPAPER"

# Check the exit status of the wal command
if [ $? -eq 0 ]; then
    # Source the colors only if wal was successful
    source "$HOME/.cache/wal/colors.sh"
    echo "Successfully updated color scheme with wal."
else
    echo "Error: 'wal' command failed."
    exit 1
fi
