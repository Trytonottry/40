#!/usr/bin/env bash
set -e
echo "🔒 Installing USB-Warden..."
sudo mkdir -p /etc/usb-warden
sudo cp driver/linux/usb_warden.ko /lib/modules/$(uname -r)/extra/
echo "usb_warden" | sudo tee /etc/modules-load.d/usb-warden.conf
sudo depmod -a
sudo modprobe usb_warden
echo "✅ Driver loaded. Use 'wardenctl add --serial <sn> --cert ca.pem' to whitelist USB."