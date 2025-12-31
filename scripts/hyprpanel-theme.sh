#!/bin/bash

# --- Configuration ---
THEMES_DIR_GLOBAL="/usr/share/hyprpanel/themes"
# 🎯 New directory for user-specific themes
THEMES_DIR_USER="$HOME/.config/hyprpanel/themes"
ROFI_PROMPT="Select Theme"

# --- Main Logic ---

# 1. Check if at least one of the themes directories exists
if [[ ! -d "$THEMES_DIR_GLOBAL" ]] && [[ ! -d "$THEMES_DIR_USER" ]]; then
    exit 1
fi

# 2. Get the list of .json files from BOTH directories and combine them.

# Function to safely get themes from a directory
get_themes() {
    local dir="$1"
    # Check if the directory exists before trying to find files in it
    if [[ -d "$dir" ]]; then
        # Use find to list .json files, print just the filename, and strip the '.json' extension
        find "$dir" -maxdepth 1 -name "*.json" -printf "%f\n" 2>/dev/null | sed 's/\.json$//'
    fi
}

# Collect and combine theme lists
THEME_LIST_GLOBAL=$(get_themes "$THEMES_DIR_GLOBAL")
THEME_LIST_USER=$(get_themes "$THEMES_DIR_USER")

# Combine lists, remove duplicates (using sort -u, which is safe even if one list is empty), and format for Rofi
THEME_LIST=$(echo -e "$THEME_LIST_GLOBAL\n$THEME_LIST_USER" | sort -u)

# Check if any themes were found at all
if [[ -z "$THEME_LIST" ]]; then
    exit 1
fi

# 3. Pipe the combined theme list to Rofi and capture the user's selection.
CHOSEN_THEME=$(echo -e "$THEME_LIST" | rofi -dmenu -i -p "$ROFI_PROMPT")

# 4. Check if a theme was selected (user didn't press Esc or cancel).
if [[ -n "$CHOSEN_THEME" ]]; then
    # Determine the full path to the chosen theme file.
    # We check the user directory first, as local files often override global ones.
    THEME_FILE_USER="$THEMES_DIR_USER/$CHOSEN_THEME.json"
    THEME_FILE_GLOBAL="$THEMES_DIR_GLOBAL/$CHOSEN_THEME.json"

    if [[ -f "$THEME_FILE_USER" ]]; then
        FINAL_THEME_PATH="$THEME_FILE_USER"
    elif [[ -f "$THEME_FILE_GLOBAL" ]]; then
        FINAL_THEME_PATH="$THEME_FILE_GLOBAL"
    else
        # Should not happen if THEME_LIST was correctly generated, but good for robustness
        exit 1
    fi

    # Execute the hyprpanel command with the selected theme's full path.
    hyprpanel useTheme "$FINAL_THEME_PATH"
else
    # Handle the case where the user cancels the selection
    exit 1
fi
