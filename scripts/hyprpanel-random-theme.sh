#!/bin/bash

# --- Configuration ---
THEMES_DIR_GLOBAL="/usr/share/hyprpanel/themes"
THEMES_DIR_USER="$HOME/.config/hyprpanel/themes"
EXCLUDE_PATTERN="split" # Exclude themes containing this word

# --- Functions ---

# Function to safely get themes from a directory
get_themes() {
    local dir="$1"
    local exclude_pat="$2"
    # Check if the directory exists before trying to find files in it
    if [[ -d "$dir" ]]; then
        # Use find to list .json files, print just the filename, strip '.json',
        # and then use grep to exclude files matching the pattern.
        find "$dir" -maxdepth 1 -name "*.json" -printf "%f\n" 2>/dev/null \
            | sed 's/\.json$//' \
            | grep -v -i "$exclude_pat" # Case-insensitive exclusion
    fi
}

# --- Main Logic ---

# 1. Check if at least one of the themes directories exists
if [[ ! -d "$THEMES_DIR_GLOBAL" ]] && [[ ! -d "$THEMES_DIR_USER" ]]; then
    echo "Error: Neither theme directory exists." >&2
    exit 1
fi

# 2. Get the list of all valid themes (excluding the pattern).
THEME_LIST_GLOBAL=$(get_themes "$THEMES_DIR_GLOBAL" "$EXCLUDE_PATTERN")
THEME_LIST_USER=$(get_themes "$THEMES_DIR_USER" "$EXCLUDE_PATTERN")

# Combine lists and remove duplicates.
THEME_LIST=$(echo -e "$THEME_LIST_GLOBAL\n$THEME_LIST_USER" | sort -u)

# Check if any themes were found at all
if [[ -z "$THEME_LIST" ]]; then
    echo "Error: No valid themes found after exclusion." >&2
    exit 1
fi

# 3. Select a random theme from the combined list.

# Count the number of themes
NUM_THEMES=$(echo -e "$THEME_LIST" | wc -l)

# Generate a random line number (1 to NUM_THEMES)
RANDOM_LINE=$(( ( RANDOM % NUM_THEMES ) + 1 ))

# Use sed to extract the theme name at the random line
CHOSEN_THEME=$(echo -e "$THEME_LIST" | sed -n "${RANDOM_LINE}p")

# 4. Determine the full path to the chosen theme file.
# The original script's logic to prefer the user path is retained.

THEME_FILE_USER="$THEMES_DIR_USER/$CHOSEN_THEME.json"
THEME_FILE_GLOBAL="$THEMES_DIR_GLOBAL/$CHOSEN_THEME.json"
FINAL_THEME_PATH=""

if [[ -f "$THEME_FILE_USER" ]]; then
    FINAL_THEME_PATH="$THEME_FILE_USER"
elif [[ -f "$THEME_FILE_GLOBAL" ]]; then
    FINAL_THEME_PATH="$THEME_FILE_GLOBAL"
fi

if [[ -z "$FINAL_THEME_PATH" ]]; then
    echo "Error: Could not find the file for theme '$CHOSEN_THEME'." >&2
    exit 1
fi

# 5. Execute the hyprpanel command with the selected theme's full path.
echo "Applying random theme: $CHOSEN_THEME from $FINAL_THEME_PATH"
hyprpanel useTheme "$FINAL_THEME_PATH"

# End with success
exit 0
