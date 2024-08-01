#!/bin/bash
# (c) J~net 2024
#
# ./test.sh start
#
#
# Configuration
LOGGING=false
LOG_FILE='/var/log/ap_manager.log'
SSID='JNET'
WPA_PASSPHRASE='password'

# Function to log messages
log() {
    if [ "$LOGGING" = true ]; then
        echo "$(date) - $1" >> "$LOG_FILE"
    fi
}

# Function to start Wi-Fi Access Point
start_wifi_ap() {
    log 'Starting Wi-Fi Access Point setup...'

    # Unmask, enable, and start hostapd
    sudo rfkill unblock wifi
    sudo ip link set wlan0 up
    sudo systemctl unmask hostapd
    sudo systemctl enable hostapd
    sudo systemctl start hostapd
    if [ $? -eq 0 ]; then
        log 'hostapd service started successfully.'
    else
        log 'Error occurred starting hostapd service.'
        exit 1
    fi

    # Start dnsmasq
    sudo systemctl start dnsmasq
    if [ $? -eq 0 ]; then
        log 'dnsmasq service started successfully.'
    else
        log 'Error occurred starting dnsmasq service.'
        exit 1
    fi
}

# Function to stop Wi-Fi Access Point
stop_wifi_ap() {
    log 'Stopping Wi-Fi Access Point services...'

    # Stop hostapd
    sudo systemctl stop hostapd
    if [ $? -eq 0 ]; then
        log 'hostapd service stopped successfully.'
    else
        log 'Error occurred stopping hostapd service.'
        exit 1
    fi

    # Stop dnsmasq
    sudo systemctl stop dnsmasq
    if [ $? -eq 0 ]; then
        log 'dnsmasq service stopped successfully.'
    else
        log 'Error occurred stopping dnsmasq service.'
        exit 1
    fi
}

# Main script logic
ACTION=$1
case "$ACTION" in
    start)
        start_wifi_ap
        ;;
    stop)
        stop_wifi_ap
        ;;
    *)
        echo 'Invalid action. Please enter "start" or "stop".'
        exit 1
        ;;
esac

