#!/bin/bash

# Define the menu items (each on a new line)
MENU_ITEMS="hyprland-wiki
edit-dotfiles
change-theme
btop
nvtop
open-app-info"

# Use dmenu to present the options and capture the user's choice.
# -l 10: sets the number of lines to display
# -p "Run Command:": sets the prompt text
CHOICE=$(echo -e "$MENU_ITEMS" | vicinae dmenu -p "Select a shortcut")

# Check which option the user selected
case "$CHOICE" in
        hyprland-wiki)
        # --- Command for 'hyprland wiki' ---
        exec uwsm app -- zen-browser --new-window "wiki.hyprland.org/"
        ;;
        edit-dotfiles)
        # --- Command for 'edit dotfiles' ---
        uwsm app -- zeditor -n ~/dotfiles/
        ;;
        btop)
        # --- Command for 'btop' ---
        # Example: Replace the echo/notify-send with 'exec gnome-control-center &' or your preferred settings app.
        uwsm app -s b -- kitty -e "btop"
        ;;
        change-theme)
        # --- Command for 'change theme' ---
        # Example: Replace the echo/notify-send with 'exec qalculate-gtk &' or your preferred calculator app.
        uwsm app -s b -- python $HOME/.config/hypr/scripts/ch-wall.py
        ;;
        open-app-info)
        # --- Command for 'hyprctl clients' ---
        #
        uwsm app -s b -- kitty -T "hyprctl-clients" sh -c '
                            echo "--- Running Hyprctl clients ---";
                            hyprctl clients; # <-- Your command is now here
                            echo "--- Command finished. Press Enter to close. ---";
                            read -r;
                        ' &
        ;;
        nvtop)
        # --- Command for 'nvtop' ---
        # Example: Replace the echo/notify-send with 'exec gnome-control-center &' or your preferred settings app.
        uwsm app -s b -- kitty -e "nvtop"
        ;;
    *)
        # Handle empty selection or pressing Escape
        ;;
esac
