#!/bin/bash

aws rds copy-db-cluster-snapshot \
  --source-db-cluster-snapshot-identifier arn:aws:rds:us-east-1:385227289220:cluster-snapshot:rds:app-test-1-2023-04-05-05-33 \
  --target-db-cluster-snapshot-identifier myclustersnapshotcopy \
  --copy-tags \
  --kms-key-id arn:aws:kms:us-west-2:385227289220:key/ed6db27a-76c3-48b2-983e-4abeae2e2d84 \
  --source-region us-east-1 \
  --region us-west-2