#!/bin/bash

# Define the menu items (each on a new line)
MENU_ITEMS="pkill
hyprland-wiki
edit-dotfiles
change-theme
btop
nvtop
open-app-info
"

# Use dmenu to present the options and capture the user's choice.
# -l 10: sets the number of lines to display
# -p "Run Command:": sets the prompt text
CHOICE=$(echo -e "$MENU_ITEMS" | vicinae dmenu -p "Select a shortcut")

# Check which option the user selected
case "$CHOICE" in
        hyprland-wiki)
            uwsm app -- zen-browser --new-window "wiki.hyprland.org/"
        ;;
        edit-dotfiles)
            uwsm app -- zeditor -n ~/dotfiles/
        ;;
        btop)
            uwsm app -s b -- kitty -e "btop"
        ;;
        change-theme)
            uwsm app -s b -- python $HOME/.config/hypr/scripts/ch-wall.py
        ;;
        open-app-info)
            uwsm app -s b -- kitty -T "hyprctl-clients" sh -c '
                            echo "--- Running Hyprctl clients ---";
                            hyprctl clients; # <-- Your command is now here
                            echo "--- Command finished. Press Enter to close. ---";
                            read -r;
                        ' &
        ;;
        nvtop)
            uwsm app -s b -- kitty -e "nvtop"
        ;;
        pkill)
            PROCESS_NAME=$(echo "" | vicinae dmenu -p "Pkill (Type Process Name):")

            if [ -n "$PROCESS_NAME" ]; then
                notify-send "Pkill Menu" "Attempting to kill processes matching: $PROCESS_NAME"
                pkill -f "$PROCESS_NAME"
            else
                notify-send "pkill" "No process name entered. Aborting pkill."
            fi
        ;;
    *)
        # Handle empty selection or pressing Escape
        ;;
esac
