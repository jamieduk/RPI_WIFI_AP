# sudo python3 ap_manager.py start
#
#
import os
import subprocess
import logging

# Configuration
LOGGING=False
LOG_FILE='/var/log/ap_manager.log'
SSID='JNET'
WPA_PASSPHRASE='password'

# Set up logging
if LOGGING:
    logging.basicConfig(filename=LOG_FILE, level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

def log(message):
    if LOGGING:
        logging.info(message)

def setup_wifi_ap():
    try:
        log('Starting Wi-Fi Access Point setup...')
        
        # Unblock wireless and bring interface up
        subprocess.run(['sudo', 'rfkill', 'unblock', 'wifi'], check=True)
        subprocess.run(['sudo', 'ip', 'link', 'set', 'wlan0', 'up'], check=True)
        log('Wireless interface unblocked and brought up successfully.')

        # Unmask, enable, and start hostapd
        subprocess.run(['sudo', 'systemctl', 'unmask', 'hostapd'], check=True)
        subprocess.run(['sudo', 'systemctl', 'enable', 'hostapd'], check=True)
        subprocess.run(['sudo', 'systemctl', 'start', 'hostapd'], check=True)
        log('hostapd service started successfully.')

        # Start dnsmasq
        subprocess.run(['sudo', 'systemctl', 'start', 'dnsmasq'], check=True)
        log('dnsmasq service started successfully.')

    except subprocess.CalledProcessError as e:
        log(f'Error occurred: {e}')
        raise

def stop_wifi_ap():
    try:
        log('Stopping Wi-Fi Access Point services...')
        # Stop hostapd
        subprocess.run(['sudo', 'systemctl', 'stop', 'hostapd'], check=True)
        log('hostapd service stopped successfully.')

        # Stop dnsmasq
        subprocess.run(['sudo', 'systemctl', 'stop', 'dnsmasq'], check=True)
        log('dnsmasq service stopped successfully.')

    except subprocess.CalledProcessError as e:
        log(f'Error occurred: {e}')
        raise

if __name__ == '__main__':
    action=input('Enter action (start/stop): ').strip().lower()
    if action == 'start':
        setup_wifi_ap()
    elif action == 'stop':
        stop_wifi_ap()
    else:
        print('Invalid action. Please enter "start" or "stop".')

