#!/bin/bash

# Set the date format to match the AMI name format
DATE=$(date +%Y%m%d)

# Log file
LOG_FILE="/home/ec2-user/anjumy/scripts/AMI/ami-logs/ami-verification-$DATE.log"

# Retrieve all AMIs created today in us-east-1 region with the specific naming convention
AMI_IDS_USEAST=$(aws ec2 describe-images --owners self --filters "Name=name,Values=*-backup-$DATE" --region us-east-1 --query 'Images[*].{ID:ImageId, CreationDate:CreationDate}' --output table)

# Retrieve all AMIs created today in us-west-2 region with the specific naming convention
AMI_IDS_USWEST=$(aws ec2 describe-images --owners self --filters "Name=name,Values=*-backup-$DATE" --region us-west-2 --query 'Images[*].{ID:ImageId, CreationDate:CreationDate}' --output table)

# Count the number of AMIs created today in us-east-1 and us-west-2 regions
TOTAL_AMIS_USEAST=$(echo "$AMI_IDS_USEAST" | wc -l)
TOTAL_AMIS_USWEST=$(echo "$AMI_IDS_USWEST" | wc -l)

# Write AMI IDs to log file for us-east-1 region
echo "AMI ID and creation date for AMIs created on $DATE in us-east-1 region:" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"
echo "$AMI_IDS_USEAST" >> "$LOG_FILE"

# Write a blank line to separate the list of AMIs from us-east-1 and us-west-2 regions in the log file
echo "" >> "$LOG_FILE"

# Write AMI IDs to log file for us-west-2 region
echo "AMI ID and creation date for AMIs created on $DATE in us-west-2 region:" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"
echo "$AMI_IDS_USWEST" >> "$LOG_FILE"

# Count the number of lines in log file that have AMI IDs only for each region
AMI_ID_LINES_USEAST=$(grep -c "ami-" <<< "$AMI_IDS_USEAST")
AMI_ID_LINES_USWEST=$(grep -c "ami-" <<< "$AMI_IDS_USWEST")

# Calculate the total number of AMIs created today in both regions
TOTAL_AMIS=$(expr $AMI_ID_LINES_USEAST + $AMI_ID_LINES_USWEST)

# Print the number of AMIs created today in us-east-1 and us-west-2 regions separately
echo "Total number of AMIs created today in us-east-1 region: $AMI_ID_LINES_USEAST" >> "$LOG_FILE"
echo "Total number of AMIs created today in us-west-2 region: $AMI_ID_LINES_USWEST" >> "$LOG_FILE"

# Print the total number of AMIs created today in both regions
echo "Total number of AMIs created today in both regions: $TOTAL_AMIS" >> "$LOG_FILE"
