#!/bin/bash

# Define backup directory
BACKUP_DIR="Config_Backup"

# Function to restore files
restore_file() {
    local src="$1"
    local dest="$2"
    
    if [ -f "$src" ]; then
        sudo cp "$src" "$dest"
        echo "Restored $src to $dest"
    else
        echo "Source file $src does not exist. Skipping."
    fi
}

# Function to restore directories
restore_dir() {
    local src="$1"
    local dest="$2"
    
    if [ -d "$src" ]; then
        sudo cp -r "$src" "$dest"
        echo "Restored directory $src to $dest"
    else
        echo "Source directory $src does not exist. Skipping."
    fi
}

# Restore hostapd configuration
restore_file "$BACKUP_DIR/hostapd.conf" "/etc/hostapd/hostapd.conf"

# Restore dnsmasq configuration
restore_file "$BACKUP_DIR/dnsmasq.conf" "/etc/dnsmasq.conf"

# Restore dnsmasq additional configurations (if applicable)
restore_dir "$BACKUP_DIR/dnsmasq.d/" "/etc/dnsmasq.d/"

# Restore network interface configurations
restore_file "$BACKUP_DIR/interfaces" "/etc/network/interfaces"
restore_dir "$BACKUP_DIR/netplan/" "/etc/netplan/"

# Restore IP tables rules
restore_file "$BACKUP_DIR/rules.v4" "/etc/iptables/rules.v4"
restore_file "$BACKUP_DIR/rules.v6" "/etc/iptables/rules.v6"

# Restore systemd service files
restore_file "$BACKUP_DIR/hostapd.service" "/lib/systemd/system/hostapd.service"
restore_file "$BACKUP_DIR/dnsmasq.service" "/lib/systemd/system/dnsmasq.service"

# Restore custom scripts (if needed)
#restore_dir "$BACKUP_DIR/scripts/" "/home/user/scripts/"

# Reload systemd services
sudo systemctl daemon-reload

# Restart services to apply changes
sudo systemctl restart hostapd
sudo systemctl restart dnsmasq

echo "Restore process completed."

