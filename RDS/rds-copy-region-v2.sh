#!/bin/bash

# Set the name of the source RDS snapshot
SOURCE_SNAPSHOT_NAME="my-automated-snapshot"

# Set the names of the two Aurora clusters
CLUSTER_NAMES=("applications-rds-auroradbcluster-iogecgelirrc" "app-test-1")

# Get the current date in YYYY-MM-DD format
TODAY=$(date +%F)

# Loop through the cluster names and copy the snapshot for each one
for CLUSTER_NAME in "${CLUSTER_NAMES[@]}"
do
  # Get the source snapshot ARN for the specified date
  SOURCE_SNAPSHOT_IDENTIFIER=$(aws rds describe-db-cluster-snapshots \
    --db-cluster-identifier $CLUSTER_NAME \
    --snapshot-type automated \
    --query "reverse(sort_by(DBClusterSnapshots[?SnapshotCreateTime>='$TODAY'], &SnapshotCreateTime))[0].DBClusterSnapshotIdentifier" \
    --output text)

  # Get the KMS key ID for the Aurora cluster
  KMS_KEY_ID=arn:aws:kms:us-west-2:385227289220:key/ed6db27a-76c3-48b2-983e-4abeae2e2d84
  #$(aws rds describe-db-clusters \
   # --db-cluster-identifier $CLUSTER_NAME \
   # --query 'DBClusters[0].KmsKeyId' \
   # --output text)

   

  # Copy the source snapshot to the destination region
  TARGET_SNAPSHOT_IDENTIFIER="${CLUSTER_NAME}-${SOURCE_SNAPSHOT_NAME}"
  aws rds copy-db-cluster-snapshot \
    --source-db-cluster-snapshot-identifier "arn:aws:rds:us-east-1:385227289220:cluster-snapshot:$SOURCE_SNAPSHOT_IDENTIFIER" \
    --target-db-cluster-snapshot-identifier "$TARGET_SNAPSHOT_IDENTIFIER" \
    --kms-key-id "$KMS_KEY_ID" \
    --copy-tags \
    --source-region us-east-1 \
    --region us-west-2

done
