#!/bin/bash
# (c) J~net 2024


python3 -m venv .
        
echo "Starting Wifi AP On Wlan0"

sudo python3 ap_manager.py start
