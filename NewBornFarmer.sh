#!/bin/bash

# V0.1
UserName=`whoami`
sudo mkdir ./$UserName
ip a > ~/IP_Info.txt
sudo mv ~/IP_Info.txt ./$UserName/
#
sudo apt update
sudo apt upgrade -y
sudo apt install openssh-server -y
sudo apt install git -y
sudo apt install smartmontools -y
sudo apt install tmux -y
sudo apt install htop -y
sudo apt install vim -y
sudo apt-get install ledmon -y
sudo apt-get install nvme-cli

mkdir ~/Documents

sudo chown -R `whoami` /mnt/*

sudo chown -R `whoami` /media/*

echo "Install CHIA"
cd ~/Documents
git clone https://github.com/Chia-Network/chia-blockchain.git -b latest --recurse-submodules
cd chia-blockchain
sh install.sh
. ./activate


