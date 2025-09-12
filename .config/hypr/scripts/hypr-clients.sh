#!/bin/bash

# hypr-clients.sh
#
# This script queries Hyprland for a list of clients (windows),
# processes the data with jq, and outputs a JSON array formatted
# for consumption by a HyprPanel custom module.

# Get the list of clients from hyprctl in JSON format.
# Filter out floating windows and windows on special workspaces if desired.
# For each client, create a new JSON object with the required fields.
hyprctl -j clients | jq -c '
    map(
        select(.workspace.name!= "special") |
        {
            "class":.class,
            "address":.address,
            "title":.title,
            "workspace":.workspace.id,
            "focused":.focused
        }
    )
'
