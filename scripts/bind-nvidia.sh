#!/bin/bash

# Ensure the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Error: Please run this script as root."
  exit 1
fi

# 1. Unbind the GPU and Audio controller from vfio-pci
echo "Unbinding RTX 3060 from vfio-pci..."
if [ -e /sys/bus/pci/drivers/vfio-pci/0000:04:00.0 ]; then
    echo "0000:04:00.0" > /sys/bus/pci/drivers/vfio-pci/unbind
fi
if [ -e /sys/bus/pci/drivers/vfio-pci/0000:04:00.1 ]; then
    echo "0000:04:00.1" > /sys/bus/pci/drivers/vfio-pci/unbind
fi

# 2. Load the NVIDIA modules
echo "Loading NVIDIA kernel modules..."
modprobe nvidia
modprobe nvidia_uvm
modprobe nvidia_drm modeset=1

# 3. Bind the devices to their host drivers
# Note: Errors are suppressed in case udev automatically bound them upon modprobe
echo "Binding to NVIDIA and snd_hda_intel drivers..."
echo "0000:04:00.0" > /sys/bus/pci/drivers/nvidia/bind 2>/dev/null
echo "0000:04:00.1" > /sys/bus/pci/drivers/snd_hda_intel/bind 2>/dev/null

# 4. Verify output
echo "Done! Verifying current driver state:"
lspci -nnk -s 04:00
