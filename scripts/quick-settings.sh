#!/bin/bash

# Define the menu items (each on a new line)
MENU_ITEMS="pkill
files
lms
edit-dotfiles
gamemode
change-theme
open-app-info
system-monitors
hyprland-wiki
nv-readme"
# Submenu definitions
MONITOR_ITEMS="btop
nvtop
htop"
LMS_ITEMS="lmstudio
lms-server"

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
                    # Present the submenu options
                    MONITOR_CHOICE=$(echo -e "$MONITOR_ITEMS" | rofi -dmenu -p "Select top")

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
                lms)
                    # Present the submenu options
                    LMS=$(echo -e "$LMS_ITEMS" | rofi -dmenu)

                    # Execute the selected monitor
                    case "$LMS" in
                        lmstudio)
                            uwsm app -- lmstudio
                            ;;
                        lms-server)
                            systemctl --user start lms-server.service
                            ;;
                        lms-and-server)
                            uwsm app -- lmstudio
                            sleep 5
                            systemctl --user start lms-server.service
                            ;;
                        *)
                            # Handle empty selection or pressing Escape in the submenu
                            ;;
                    esac
                ;;
                pkill)
                            # Use ps to get a list of running process names for the CURRENT USER ($USER)
                            # -u $USER: filters processes by the current user
                            # -o comm: outputs the command name only
                            # awk '!x[$0]++': filters for unique names
                            PROCESS_LIST=$(ps -u $USER -o comm | awk '!x[$0]++' | sort)

                            # Present the unique user process names to the user via rofi
                            PROCESS_NAME=$(echo -e "$PROCESS_LIST" | rofi -dmenu -w 40 -p "Pkill:")

                            if [ -n "$PROCESS_NAME" ]; then
                                notify-send "Pkill Menu" "Attempting to kill all processes named: $PROCESS_NAME"

                                # Basic safety check (add any other critical processes you want to guard against)
                                if [[ "$PROCESS_NAME" == "bash" || "$PROCESS_NAME" == "sh" || "$PROCESS_NAME" == "rofi" || "$PROCESS_NAME" == "dmenu" ]]; then
                                    notify-send "Pkill Menu" "Cannot kill critical system process: $PROCESS_NAME"
                                else
                                    # Use pkill with the exact command name (-x)
                                    pkill -x "$PROCESS_NAME"

                                    # Optional: Add a check for successful kill
                                    if [ $? -eq 0 ]; then
                                        notify-send "Pkill Menu" "Successfully killed processes matching: $PROCESS_NAME"
                                    else
                                        notify-send "Pkill Menu" "No processes found or error killing: $PROCESS_NAME"
                                    fi
                                fi

                            else
                                notify-send "pkill" "No process selected. Aborting pkill."
                            fi
                        ;;
        files)
            rofi -show filebrowser -config .config/rofi/config.rasi -p "Shift+Enter to open"
        ;;
        nv-readme)
            sh -e "$HOME/dotfiles/scripts/nvidia-readme.sh"
        ;;
        gamemode)
            sh -e "$HOME/.config/hypr/scripts/gamemode.sh"
        ;;
    *)
        # Handle empty selection or pressing Escape
        ;;
esac
