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
  # Get the source snapshot identifier for the specified date
  SOURCE_SNAPSHOT_IDENTIFIER=$(aws rds describe-db-cluster-snapshots \
    --db-cluster-identifier $CLUSTER_NAME \
    --snapshot-type automated \
    --query "reverse(sort_by(DBClusterSnapshots[?SnapshotCreateTime>='$TODAY'], &SnapshotCreateTime))[0].DBClusterSnapshotIdentifier" \
    --output text)

echo -e $SOURCE_SNAPSHOT_IDENTIFIER

  # Copy the source snapshot to the destination region
  TARGET_SNAPSHOT_IDENTIFIER="${CLUSTER_NAME}-${SOURCE_SNAPSHOT_NAME}"
  aws rds copy-db-cluster-snapshot \
    --source-db-cluster-snapshot-identifier "${SOURCE_SNAPSHOT_IDENTIFIER}" \
    --target-db-cluster-snapshot-identifier "$TARGET_SNAPSHOT_IDENTIFIER" \
    --source-region us-east-1 \
    --region us-west-2
done
