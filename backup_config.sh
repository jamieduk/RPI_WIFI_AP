#!/bin/bash

# Define backup directory
BACKUP_DIR="Config_Backup"

# Create backup directory if it does not exist
mkdir -p "$BACKUP_DIR"

# Function to back up files
backup_file() {
    local src="$1"
    local dest="$2"
    
    if [ -f "$src" ]; then
        cp "$src" "$dest"
        echo "Backed up $src to $dest"
    else
        echo "Source file $src does not exist. Skipping."
    fi
}

# Function to back up directories
backup_dir() {
    local src="$1"
    local dest="$2"
    
    if [ -d "$src" ]; then
        cp -r "$src" "$dest"
        echo "Backed up directory $src to $dest"
    else
        echo "Source directory $src does not exist. Skipping."
    fi
}

# Back up hostapd configuration
backup_file "/etc/hostapd/hostapd.conf" "$BACKUP_DIR/hostapd.conf"

# Back up dnsmasq configuration
backup_file "/etc/dnsmasq.conf" "$BACKUP_DIR/dnsmasq.conf"

# Back up dnsmasq additional configurations (if applicable)
backup_dir "/etc/dnsmasq.d/" "$BACKUP_DIR/dnsmasq.d/"

# Back up network interface configurations
backup_file "/etc/network/interfaces" "$BACKUP_DIR/interfaces"
backup_dir "/etc/netplan/" "$BACKUP_DIR/netplan/"

# Back up IP tables rules
backup_file "/etc/iptables/rules.v4" "$BACKUP_DIR/rules.v4"
backup_file "/etc/iptables/rules.v6" "$BACKUP_DIR/rules.v6"

# Back up systemd service files
backup_file "/lib/systemd/system/hostapd.service" "$BACKUP_DIR/hostapd.service"
backup_file "/lib/systemd/system/dnsmasq.service" "$BACKUP_DIR/dnsmasq.service"

# Back up custom scripts (if needed)
#backup_dir "/home/user/scripts/" "$BACKUP_DIR/scripts/"

echo "Backup process completed."

