#!/bin/bash
# (c) J~net 2024


sudo journalctl -u dnsmasq | grep 'DHCPACK'

