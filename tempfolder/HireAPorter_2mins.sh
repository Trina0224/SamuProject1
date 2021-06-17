#!/bin/bash
crontab 2mins.cronbackup

crontab -l

#manually use, crontab -e and put
#   */30 * * * * /home/Porter/Porter.sh
#at the end of the file. This will run Porter every 30 mins.
