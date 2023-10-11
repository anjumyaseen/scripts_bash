#!/bin/bash

# Set the region and date format
REGION="us-east-1"
DATE_FORMAT="%Y-%m-%d"

# Get the current date in the desired format
CURRENT_DATE=$(date +${DATE_FORMAT})

# Log file
LOG_FILE="/home/ec2-user/anjumy/scripts/RDS/rds-logs/rds-verification-$CURRENT_DATE.log"

# Log file
#LOG_FILE="rds-verification-$CURRENT_DATE.log"

# Use the AWS CLI to describe RDS snapshots for today in the given region
RDS_List=$(aws rds describe-db-cluster-snapshots \
  --region ${REGION} \
  --query "DBClusterSnapshots[?contains(SnapshotCreateTime, \`${CURRENT_DATE}\`) == \`true\`].{ID:DBClusterSnapshotIdentifier, Created:SnapshotCreateTime}" \
  --output table)

# Count the number of AMIs created today in us-east-1 region
TOTAL_RDS_Snapshots=$(echo "$RDS_List" | wc -l)    

# Subtract 6 from the total number of RDS snapshots
TOTAL_RDS_Snapshots=$(expr $TOTAL_RDS_Snapshots - 6)

# Write RDS snapshot list to log file
    echo "RDS_List" > "$LOG_FILE"  

# Count the number of lines in log file that have AMI IDs only
    #RDS_LINES=$(grep -c "^$CURRENT_DATE" "$LOG_FILE") 
    
# Verify if there are any RDS Snapshots that meet the above criteria
if [ $TOTAL_RDS_Snapshots -eq 0 ]
then
    echo "No RDS Snapshots created today in us-east-1 region with the specific naming convention found" >> "$LOG_FILE"
else
    echo "Total number of RDS Snapshots created today in us-east-1 region: $RDS_List" >> "$LOG_FILE"
    #echo "Total number of lines in log file that have AMI IDs only: $RDS_LINES" >> "$LOG_FILE"
    #echo "AMI ID and creation date for AMIs created $DATE in us-east-1 region:" >> "$LOG_FILE"
    echo "Total number of RDS Snapshots created today in us-east-1 region: $TOTAL_RDS_Snapshots" >> "$LOG_FILE"
fi    



