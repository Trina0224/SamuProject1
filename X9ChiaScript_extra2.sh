#!/bin/bash

SESSION="chiaInit"
SESSIONEXISTS=$(tmux list-sessions | grep $SESSION)

#   /mnt/temp1 --> SATA 2TB
#   /mnt/temp2 --> SATA 2TB  
#   /mnt/plotting --> SATA 8TB  
#   My Idea is just let eveything go and create one Cron-job to check plots all the time. 

FKEY="89ed09368db9ac6e818615291e26458c9bbae2a360caf6e18da33e496265bdbb4528beaf4e327e21262f2dbf32292a90"
PKEY="91b4441ed09ad17f0618720b3c6b5dc68b90a2cdb3a2bea95bb6b66c493abf28438a91ba740d705b7ebf5ae4fda210a5"
#PLOTSIZE="25"
PLOTSIZE="32"
#ITERATIONS="1"
PLOTNUMBER="1"
THREADSONEACHTMP="1"

#
#--override-k

#the defination of temp locations is different from CHIA.
#tmpLocation1 means SSD 1
#tmpLocation2 means SSD 2
TMPLOCATION1="/mnt/temp1"
TMPLOCATION2="/mnt/temp2"

FINALLOCATION="/mnt/plotting"

echo "Run with" 
echo "FKEY=$FKEY"
echo "PKEY=$PKEY"

#echo "chia plots create -f 89ed09368db9ac6e818615291e26458c9bbae2a360caf6e18da33e496265bdbb4528beaf4e327e21262f2dbf32292a90 -p 91b4441ed09ad17f0618720b3c6b5dc68b90a2cdb3a2bea95bb6b66c493abf28438a91ba740d705b7ebf5ae4fda210a5 --override-k -k 25 -n 3 -t /mnt/nvme0 -d /mnt/sdb | tee /mnt/sdb/small0.log 
#"
COMBINEDCMD1="chia plots create -f ${FKEY} -p ${PKEY} --override-k -k ${PLOTSIZE} -n ${PLOTNUMBER} -t ${TMPLOCATION1} -d ${TMPLOCATION1} | tee ${FINALLOCATION}/" #need xxx.log
COMBINEDCMD2="chia plots create -f ${FKEY} -p ${PKEY} --override-k -k ${PLOTSIZE} -n ${PLOTNUMBER} -t ${TMPLOCATION2} -d ${TMPLOCATION2} | tee ${FINALLOCATION}/" #need yyy.log
#echo $COMBINEDCMD1

#Only create tmux Session if it doesn't already exist
if [ "$SESSIONEXISTS" = "" ]
then
    # Initial Chia in first tmux.
    tmux new -d -s chiaInit
    tmux send-keys -t chiaInit.0 "cd ~/Documents/chia-blockchain" ENTER
    tmux send-keys -t chiaInit.0 ". ./activate" ENTER
    tmux send-keys -t chiaInit.0 "chia init" ENTER
    #sleep 3 seconds to wait chia init sattle.
    echo "Wait chia init ready.. around 3 seconds..."
    sleep 3s 
    #
    for (( c=1; c<=$THREADSONEACHTMP; c++ ))
    do  
        echo "Create No.${c} thread on SSD1"
        echo "Create ${PLOTNUMBER} plots from ${TMPLOCATION1} to ${TMPLOCATION1}"
        tmux new -d -s N${c}SSD1
        tmux send-keys -t N${c}SSD1.0 "cd ~/Documents/chia-blockchain" ENTER
        tmux send-keys -t N${c}SSD1.0 ". ./activate" ENTER
        tmux send-keys -t N${c}SSD1.0 "${COMBINEDCMD1}/N${c}SSD1.log" ENTER
    done
    #
    for (( c=1; c<=$THREADSONEACHTMP; c++ ))
    do  
        echo "Create No.${c} thread on SSD2"
        echo "Create ${PLOTNUMBER} plots from ${TMPLOCATION2} to ${TMPLOCATION2}"
        tmux new -d -s N${c}SSD2
        tmux send-keys -t N${c}SSD2.0 "cd ~/Documents/chia-blockchain" ENTER
        tmux send-keys -t N${c}SSD2.0 ". ./activate" ENTER
        tmux send-keys -t N${c}SSD2.0 "${COMBINEDCMD2}/N${c}SSD2.log" ENTER
    done

else
    echo "Please run Revelation.sh manually to restart all environment."

fi
echo "----------------------------------------------"
echo "Please use commands: ex tmux ls" 
echo "tmux a -t NxSSD1 or tmux a -t NxSSD2"
echo "or just read *.log files from ${FINALLOCATION}"
