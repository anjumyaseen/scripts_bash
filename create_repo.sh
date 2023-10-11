#!/bin/bash
#This script creates the empty repos.


# Bitbucket access token for https://git-staging.gradientai.systems/
TOKEN="BBDC-ODA1NzUzMTc3MTc4OmUbw1tl7+j4eddfpBRqkRMyphmu"

# Base URL for the Bitbucket API
API_BASE_URL="https://git-staging.gradientai.systems/rest/api/1.0/projects"

# List of repository names to create
REPO_NAMES=("ami-backup" "dockerized-model-example" "gradientai-core" "gradientai-health-clean" "RepositoryPhoenixDataPipelines" "Platform")

# Project key to create repositories under
PROJECT_KEY="tes"

# Loop through the repository names and create each repository
for REPO_NAME in "${REPO_NAMES[@]}"
do
  # JSON payload for the repository creation request
  JSON="{\"name\": \"$REPO_NAME\"}"

  # Send the repository creation request using cURL and the Bitbucket API
  curl -X POST -H "Content-Type: application/json" -H "Authorization: Bearer $TOKEN" -d "$JSON" "$API_BASE_URL/$PROJECT_KEY/repos"
done
