#!/bin/bash
set -e

# Define the path to the version file
VERSION_FILE="/proc/driver/nvidia/version"

# Variable to hold the final URL (local file:// or remote https://)
FINAL_URL=""

# Check if the driver version file exists
if [ ! -f "$VERSION_FILE" ]; then
    echo "Error: NVIDIA driver version file not found at $VERSION_FILE" >&2
    echo "Please ensure the NVIDIA driver is installed and loaded." >&2
    exit 1
fi

# Read the file, find the line with "NVRM version", and use awk to find
# the field that looks like a version number (e.g., 580.95.05).
# This is more robust than relying on a fixed field number.
DRIVER_VERSION=$(awk '/NVRM version:/ {for (i=1; i<=NF; i++) if ($i ~ /^[0-9]+\.[0-9]+\.[0-9]+$/) {print $i; exit}}' "$VERSION_FILE")

# Check if we successfully extracted a version
if [ -z "$DRIVER_VERSION" ]; then
    echo "Error: Could not parse driver version from $VERSION_FILE" >&2
    exit 1
fi

# Construct the remote URL
BASE_URL="https://us.download.nvidia.com/XFree86/Linux-x86_64/"
README_PATH="/README/index.html"
FULL_URL="${BASE_URL}${DRIVER_VERSION}${README_PATH}"

# --- Part: Caching the file ---

# Define cache directory and file path
CACHE_DIR="$HOME/.cache/nvidia_readme"
CACHE_FILE="$CACHE_DIR/nvidia-readme-${DRIVER_VERSION}.html"

# Create the cache directory if it doesn't exist
mkdir -p "$CACHE_DIR"

# Check if the file is already cached
if [ -f "$CACHE_FILE" ]; then
    echo "NVIDIA README for version $DRIVER_VERSION is cached." >&2
    FINAL_URL="file://$CACHE_FILE"
else
    # Download the file
    echo "Downloading NVIDIA README for version $DRIVER_VERSION..." >&2

    # Use curl to download. -s for silent, -S to show errors, -f to fail fast, -L to follow redirects, -o to specify output file.
    if curl -sSfL "$FULL_URL" -o "$CACHE_FILE"; then
        echo "Successfully cached README." >&2
        FINAL_URL="file://$CACHE_FILE"
    else
        echo "Error: Failed to download README from $FULL_URL" >&2
        # Clean up the (likely empty) cache file on failure
        rm -f "$CACHE_FILE"

        # Fallback: If download fails, use the online URL
        echo "Using remote URL as fallback." >&2
        FINAL_URL="$FULL_URL"
    fi
fi

# Construct the full remote URL using the extracted version
BASE_URL="https://us.download.nvidia.com/XFree86/Linux-x86_64/"
README_PATH="/README/index.html"
FINAL_URL="${BASE_URL}${DRIVER_VERSION}${README_PATH}"

# --- Final Step: Launch the browser ---
if [ -n "$FINAL_URL" ]; then
    echo "Launching zen-browser with the remote README for version $DRIVER_VERSION..." >&2
    # Launch zen-browser in a new window using the final determined URL.
    # The '&' runs the browser in the background so the script exits immediately.
    zen-browser  --new-window "$FINAL_URL" &
else
    echo "Error: Could not determine a valid URL to open." >&2
    exit 1
fi
