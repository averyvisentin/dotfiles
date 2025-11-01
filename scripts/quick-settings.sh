#!/bin/bash

# Define the menu items (each on a new line)
MENU_ITEMS="pkill
files
hyprland-wiki
edit-dotfiles
change-theme
open-app-info
system-monitors
nv-readme"

# Use dmenu to present the options and capture the user's choice.
# -l 10: sets the number of lines to display
# -p "Run Command:": sets the prompt text
CHOICE=$(echo -e "$MENU_ITEMS" | rofi -window-title "rofi" -click-to-exit true -dmenu -p "Select a shortcut" -no-lazy-grab -normal-window)

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
        htop)
            uwsm app -s b -- kitty -e "htop"
        ;;
        # --- New Submenu Handling ---
                system-monitors)
                    # Define the submenu items
                    MONITOR_ITEMS="btop
nvtop
htop"

                    # Present the submenu options
                    MONITOR_CHOICE=$(echo -e "$MONITOR_ITEMS" | rofi -dmenu -p "Select Monitor")

                    # Execute the selected monitor
                    case "$MONITOR_CHOICE" in
                        btop)
                            uwsm app -s b -- kitty -e "btop"
                            ;;
                        nvtop)
                            uwsm app -s b -- kitty -e "nvtop"
                            ;;
                        htop)
                            uwsm app -s b -- kitty -e "htop"
                            ;;
                        *)
                            # Handle empty selection or pressing Escape in the submenu
                            ;;
                    esac
                ;;
        pkill) # we need to revisit this, we'd like a list of processes to choose from. because I'm getting the names 'wrong' so we need to fix it
            PROCESS_NAME=$(echo "" | rofi -dmenu -p "Pkill (Type Process Name):")

            if [ -n "$PROCESS_NAME" ]; then
                notify-send "Pkill Menu" "Attempting to kill processes matching: $PROCESS_NAME"
                pkill -f "$PROCESS_NAME"
            else
                notify-send "pkill" "No process name entered. Aborting pkill."
            fi
        ;;
        files)
            rofi -show filebrowser -config .config/rofi/config.rasi -p "Shift+Enter to open"
        ;;
        nv-readme)
            sh -e "$HOME/dotfiles/scripts/nvidia-readme.sh"
        ;;
    *)
        # Handle empty selection or pressing Escape
        ;;
esac
