#!/usr/bin/env bash


today=$(date +"%Y%m%d")
work_report="/home/ec2-user/anjumy/scripts/sonar_scan_scripts/prod/sonar_log/sonar_scanned_results_$today.txt"

#echo "TESTING" > $work_report


/home/ec2-user/anjumy/scripts/sonar_scan_scripts/prod/sonar_scan.sh > $work_report 2>&1
echo -e "DONE"