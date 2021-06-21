#!/bin/bash

echo "/dev/sda"
sudo smartctl -i /dev/sda | grep -i "User Capacity"
echo "/dev/sdb"
sudo smartctl -i /dev/sdb | grep -i "User Capacity"
echo "/dev/sdc"
sudo smartctl -i /dev/sdc | grep -i "User Capacity"
echo "/dev/sdd"
sudo smartctl -i /dev/sdd | grep -i "User Capacity"