#!/bin/bash

crontab -r
crontab 45mins.crontabBP

crontab -l

echo "Please use: systemctl status cron "
echo "to check status. "

#manually use, crontab -e and put
#   */45 * * * * /home/Porter/Porter.sh
#at the end of the file. This will run Porter every 30 mins.
