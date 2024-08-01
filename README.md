Wi-Fi Access Point Setup
This repository contains scripts and configurations for setting up a Wi-Fi access point on a Linux system using hostapd and dnsmasq. The setup includes creating a Wi-Fi access point, managing IP addresses with DHCP, and configuring necessary services.

Table of Contents
Overview
Prerequisites
Setup
Configuration
Backup and Restore
Usage
License
Overview
This project provides:

Setup Script: Installs required packages and configures hostapd and dnsmasq.
Backup Script: Backs up configuration files.
Restore Script: Restores configuration files from backup.
Configuration Files: Example configurations for hostapd and dnsmasq.
Prerequisites
Before running the setup script, ensure you have:

A Linux system with sudo privileges.
Basic network configuration knowledge.
Setup
To set up your Wi-Fi access point, follow these steps:

Clone the Repository:


git clone https://github.com/yourusername/your-repo-name.git](https://github.com/jamieduk/RPI_WIFI_AP.git
cd your-repo-name
Run the Setup Script:


sudo ./setup_wifi_ap.sh
This script installs necessary packages and starts the required services.

Configuration
Hostapd Configuration:

Edit /etc/hostapd/hostapd.conf with your desired Wi-Fi settings. Example configuration:


interface=wlan0
driver=nl80211
ssid=YOUR_SSID
hw_mode=g
channel=7
wpa=2
wpa_passphrase=YOUR_PASSWORD
wpa_key_mgmt=WPA-PSK
wpa_pairwise=TKIP
rsn_pairwise=CCMP
Dnsmasq Configuration:

Edit /etc/dnsmasq.conf with the following settings:


interface=wlan0
dhcp-range=192.168.150.2,192.168.150.20,12h
Ensure the interface and dhcp-range match your network configuration.

Backup and Restore
Backup
To back up your configuration files:


sudo ./backup_config.sh
Restore
To restore from a backup:


sudo ./restore_backup.sh
Ensure the backup directory is correctly set in the restore script.

Usage
Start Wi-Fi Access Point:


sudo ./start_wifi_ap.sh
Stop Wi-Fi Access Point:


sudo ./stop_wifi_ap.sh
License
This project is licensed under the MIT License - see the LICENSE file for details.

