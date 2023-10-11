import boto3
from datetime import datetime, timezone

today = (datetime.today()).date()
rds_client = boto3.client('rds')
snapshots = rds_client.describe_db_snapshots()

for i in snapshots['DBSnapshots']:
    if i['SnapshotCreateTime'].date() == today:
        print(i['DBSnapshotIdentifier'])
        print (today)
