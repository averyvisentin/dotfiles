#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Error: Please run this script as root."
  exit 1
fi

# 1. Stop GPU monitoring daemon before unbinding
echo "Stopping lact daemon..."
systemctl stop lactd 2>/dev/null

# 2. Unbind GPU and Audio controller from host drivers
echo "Unbinding RTX 3060 from host drivers..."
if [ -e /sys/bus/pci/drivers/nvidia/0000:04:00.0 ]; then
    echo "0000:04:00.0" > /sys/bus/pci/drivers/nvidia/unbind
fi
if [ -e /sys/bus/pci/drivers/snd_hda_intel/0000:04:00.1 ]; then
    echo "0000:04:00.1" > /sys/bus/pci/drivers/snd_hda_intel/unbind
fi

# 3. Unload NVIDIA modules
echo "Unloading NVIDIA kernel modules..."
modprobe -r nvidia_drm nvidia_uvm nvidia_modeset nvidia 2>/dev/null

# 4. Ensure vfio-pci kernel module is loaded
echo "Loading vfio-pci module..."
modprobe vfio-pci

# 5. Bind devices to vfio-pci
echo "Setting driver overrides and binding to vfio-pci..."
echo "vfio-pci" > /sys/bus/pci/devices/0000:04:00.0/driver_override
echo "vfio-pci" > /sys/bus/pci/devices/0000:04:00.1/driver_override

# Suppress EBUSY if udev already bound them automatically
echo "0000:04:00.0" > /sys/bus/pci/drivers/vfio-pci/bind 2>/dev/null
echo "0000:04:00.1" > /sys/bus/pci/drivers/vfio-pci/bind 2>/dev/null

echo "" > /sys/bus/pci/devices/0000:04:00.0/driver_override
echo "" > /sys/bus/pci/devices/0000:04:00.1/driver_override

# 6. Restart LACT daemon for AMD GPU
echo "Restarting lact daemon..."
systemctl restart lactd

# 7. Verification
echo "Done! Verifying driver state:"
lspci -nnk -s 04:00
