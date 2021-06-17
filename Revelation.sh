#!/bin/bash
echo "Discontinue all chia process..."
tmux kill-server
echo "Reset Porters..."
rm /home/Porter/*.tmp
rm /home/Porter/movinglist.txt
echo "Clean all residue..."
rm /mnt/temp1/*.tmp
rm /mnt/temp2/*.tmp
rm /mnt/plotting/*.tmp
echo "backup all log files..."
now=$(date +"%m_%d_%Y")
cd /mnt/plotting
tar zcvf backup_${now}.tar.gz *.log 
rm *.log
cd -

