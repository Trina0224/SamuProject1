#!/bin/bash
#1. This script will be run every ?? mins via CRON-JOB. 
#2. This script mantain a file ~/Documents/Porter/movinglist.txt  When it start to move a file, the script will write current
#   moving file name to this file. 
#3. Script flow chart: Start-> Check is there any .plot file in assigned tmp folder, if no --> end
#   if Yes, --> check the filename is already in the list or not, if no--> start move file, write filename in the list.
#                                                                 if yes --> check next file name
#   and keep step.3 until all files are checked and moved to final location. 


TMPLOCATION1="/mnt/temp1"
TMPLOCATION2="/mnt/temp2"
#TMPLOCATION3="/mnt/" #for testing only.
FINALLOCATION="/mnt/plotting"
MOVINGLIST="movinglist.txt"



cd /home/Porter/

#movinglist.txt check it exist or not.
FILE=$MOVINGLIST
if [ -f "$MOVINGLIST" ]; then
    echo "$MOVINGLIST exists."
else 
    echo "$MOVINGLIST does not exist. Create it now."
    touch $MOVINGLIST
fi
#Generate current plot-file log.
rm temp1.tmp
rm temp2.tmp
touch temp1.tmp temp2.tmp
ls $TMPLOCATION1/*.plot > temp1.tmp
ls $TMPLOCATION2/*.plot > temp2.tmp
#ls $TMPLOCATION3/*.plot > temp3.tmp

#Check temp1.tmp is empty or not.
if [ -s "temp1.tmp" ] 
then
	echo "SSD1 has some data."
        # do something as file has data
        file="temp1.tmp"
        while IFS= read line
        do
            # display $line or do something with $line
	        #echo "$line"
            ISFILECOPYING=$(cat $MOVINGLIST  | grep $line)
            if [ "$ISFILECOPYING" = "" ]
            then
                # This plot is waiting to move.
                echo "$line" >> $MOVINGLIST
                #because this is a cron-job, I move one plot a time.
                echo "Move $line from $TMPLOCATION1 to $FINALLOCATION"
                mv $line $FINALLOCATION &  
                break

            else
                # This plot is already in the moving stage.
                echo "$line is moving"
                
            fi

        done <"$file"
else
	echo "No plots exist on SSD1."
        # do something as file is empty 
fi

#Check temp2.tmp is empty or not.
if [ -s "temp2.tmp" ] 
then
	echo "SSD2 has some data."
        # do something as file has data
        file2="temp2.tmp"
        while IFS= read line2
        do
            # display $line or do something with $line
	        #echo "$line"
            ISFILECOPYING=$(cat $MOVINGLIST  | grep $line2)
            if [ "$ISFILECOPYING" = "" ]
            then
                # This plot is waiting to move.
                echo "$line2" >> $MOVINGLIST
                #because this is a cron-job, I move one plot a time.
                echo "Move $line2 from $TMPLOCATION2 to $FINALLOCATION"
                mv $line2 $FINALLOCATION &  
                break

            else
                # This plot is already in the moving stage.
                echo "$line2 is moving"
                
            fi

        done <"$file2"
else
	echo "No plots exist on SSD2."
        # do something as file is empty 
fi


cd -


