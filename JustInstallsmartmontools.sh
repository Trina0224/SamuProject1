#!/bin/bash

sudo apt install smartmontools -y
sudo smartctl -i /dev/sda | grep -i "User Capacity"
sudo smartctl -i /dev/sdb | grep -i "User Capacity"
sudo smartctl -i /dev/sdc | grep -i "User Capacity"
sudo smartctl -i /dev/sdd | grep -i "User Capacity"
