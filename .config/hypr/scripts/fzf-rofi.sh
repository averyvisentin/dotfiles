#!/bin/bash

# Define your main directory (replace with your actual main directory)
MAIN_DIR="$HOME" # Or any other path like /mnt/data, /home/youruser, etc.

# Use fzf to search for files in the main directory
# -f "$@" passes Rofi's initial input to fzf for pre-filtering
# -e enables exact match (optional, remove if you prefer fuzzy only)
# --print0 ensures null-separated output for safe handling of filenames with spaces
# --exit-0 ensures fzf exits with 0 even if no match is selected (good for piping)
# --no-sort (optional) if you don't want fzf to sort the results
# --height=50% --layout=reverse --border (optional) for fzf's appearance
find "$MAIN_DIR" -type f -print0 | fzf --filter="$@" --read0 --print0 --height=50% --layout=reverse --border --prompt="Search Files: "
