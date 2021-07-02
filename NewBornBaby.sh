#!/bin/bash

# V0.3
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
sudo apt-get install smartmontools -y
sudo apt-get install nvme-cli
mkdir ~/Documents
sudo mkdir /home/Porter
sudo chown -R `whoami`  /home/*
cp Porter.sh /home/Porter/
cp HireAPorter.sh /home/Porter/
cp DismissAPorter.sh /home/Porter/
cp 30mins.crontabBP /home/Porter/

sudo mkdir /mnt/temp1
sudo mkdir /mnt/temp2
sudo mkdir /mnt/plotting

# I should check /sdb /sdc /sdd are correct. In next version.  
echo "Create SSD1"
(echo d; echo n; echo ""; echo ""; echo ""; echo "";echo p; echo w; echo y) | sudo gdisk /dev/sda
(echo y) | sudo mkfs.ext4 /dev/sda1
sudo mount /dev/sda1 /mnt/temp1
echo "Create SSD2"
(echo d; echo n; echo ""; echo ""; echo ""; echo "";echo p; echo w; echo y) | sudo gdisk /dev/sdb
(echo y) | sudo mkfs.ext4 /dev/sdb1
sudo mount /dev/sdb1 /mnt/temp2
echo "Create HDD"
(echo d; echo n; echo ""; echo ""; echo ""; echo "";echo p; echo w; echo y) | sudo gdisk /dev/sdd
sudo mkfs.ntfs -f /dev/sdd1
sudo mount /dev/sdd1 /mnt/plotting

sudo chown -R `whoami` /mnt/*

sudo chown -R `whoami` /media/*

mkdir ~/.ssh
cp authorized_keys ~/.ssh


echo "Install CHIA"
cd ~/Documents
git clone https://github.com/Chia-Network/chia-blockchain.git -b latest --recurse-submodules
cd chia-blockchain
sh install.sh
. ./activate


#I still need to setup all three disks.


