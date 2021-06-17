#!/bin/bash

# V0.1
UserName=`whoami`
sudo mkdir ./$UserName
ip a > ~/IP_Info.txt
sudo mv ~/IP_Info.txt ./$UserName/
#
sudo apt update
sudo apt install openssh-server -y

