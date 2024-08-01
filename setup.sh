#!/bin/bash
# (c) J~Net 2024
#
#
#
# Define the packages to be installed
PACKAGES=(
    hostapd
    dnsmasq
    iptables
    net-tools
    wireless-tools
    ifupdown
    iproute2
)

# Update package lists
echo "Updating package lists..."
sudo apt update

# Upgrade existing packages
echo "Upgrading existing packages..."
sudo apt upgrade -y

# Install required packages
echo "Installing packages..."
for PACKAGE in "${PACKAGES[@]}"; do
    sudo apt install -y "$PACKAGE"
done

# Check if installation was successful
if [ $? -ne 0 ]; then
    echo "Error: One or more packages failed to install."
    exit 1
fi





# Provide final instructions
echo "Setup completed."
echo "Please configure /etc/hostapd/hostapd.conf and /etc/dnsmasq.conf as needed."
echo "Restart services after making configuration changes using:"
echo "sudo systemctl restart hostapd"
echo "sudo systemctl restart dnsmasq"

