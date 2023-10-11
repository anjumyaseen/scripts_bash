#!/bin/bash

SOURCE_BITBUCKET_URL="https://git.gradientai.systems"
DESTINATION_BITBUCKET_URL="https://git-staging.gradientai.systems"

# Retrieve the list of projects from the source Bitbucket (add username and password)
SOURCE_PROJECTS=$(curl --silent --user ayaseen:AleezaYamin1%% "${SOURCE_BITBUCKET_URL}/rest/api/1.0/projects?limit=1000")

# Loop over each project and create it in the destination Bitbucket
for PROJECT_KEY in $(echo "${SOURCE_PROJECTS}" | jq -r '.values[].key'); do
  PROJECT_NAME=$(echo "${SOURCE_PROJECTS}" | jq -r --arg key "${PROJECT_KEY}" '.values[] | select(.key==$key) | .name')

  echo "Copying project ${PROJECT_NAME} (${PROJECT_KEY})"

  # Create the project in the destination Bitbucket (add username and password)
  curl --silent --user ayaseen:AleezaYamin1%% --header "Content-Type: application/json" --data "{\"key\":\"${PROJECT_KEY}\",\"name\":\"${PROJECT_NAME}\"}" "${DESTINATION_BITBUCKET_URL}/rest/api/1.0/projects/" > /dev/null
done