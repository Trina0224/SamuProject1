#!/bin/bash

SDATEST=$(cat /sys/block/sda/queue/rotational)
SDBTEST=$(cat /sys/block/sdb/queue/rotational)
#SDCTEST=$(cat /sys/block/sdc/queue/rotational)
SDDTEST=$(cat /sys/block/sdd/queue/rotational)
SDD2TEST=$(df | grep -i "/dev/sdd1")

echo "Mount all disks"
if [ "$SDATEST" = "0" ]
then
	sudo mount /dev/sda1 /mnt/temp1
	echo "mount /dev/sda1 as /mnt/temp1"

else
	echo "Cannot mount /dev/sda1"
fi

if [ "$SDBTEST" = "0" ]
then
	sudo mount /dev/sdb1 /mnt/temp2
	echo "mount /dev/sdb1 as /mnt/temp2"

else
	echo "Cannot mount /dev/sdb1"
fi

if [ "$SDDTEST" = "1" ]
then
	if [ "$SDD2TEST" = "" ]
	then
		sudo mount /dev/sdd1 /mnt/plotting
		echo "mount /dev/sdd1 as /mnt/plotting"
	else
		echo "Need to check sdc and sdd order."
	fi

else
	echo "Cannot mount /dev/sdd1"
fi



#sudo mount /dev/sda1 /mnt/temp1
#sudo mount /dev/sdb1 /mnt/temp2
#sudo mount /dev/sdd1 /mnt/plotting
sudo chown -R `whoami` /mnt/*

#crontab crontab_backup
crontab -l
