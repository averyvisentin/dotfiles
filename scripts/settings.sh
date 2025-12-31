#!/bin/bash
#
SETTINGS_ITEMS="gtk-settings
qt-settings
kvantum
hyprpanel-settings"

SETTINGS=$(echo -e "$SETTINGS_ITEMS" | dmenu -p "Select a shortcut")

case "$SETTINGS" in
    gtk-settings)
        uwsm app -- nwg-look
        ;;
    qt-settings)
        uwsm app -- qt6ct
        ;;
    kvantum)
        uwsm app -- kvantum
        ;;
    hyprpanel-settings)
        uwsm app -- hyprpanel toggleWindow settings-dialog
        ;;
    *)
        # Handle empty selection or pressing Escape
        ;;
esac
