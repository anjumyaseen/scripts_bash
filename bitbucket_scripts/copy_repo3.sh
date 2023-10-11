#!/bin/bash
#This script clones the repos from PROD to STAGING.


git config --global credential.helper "cache --timeout=3600"

# Define the list of repositories to process
repositories=("ami-backup" "dockerized-model-example" "gradientai-core" "Platform")

# Loop through each repository and perform the same task
for repo_name in "${repositories[@]}"
do
    # Replace the placeholders with the actual values
    project_key="tes"
    empty_repo_url="https://git-staging.gradientai.systems/scm/$project_key/$repo_name.git"

    # Clone the original repository
    git clone --mirror https://git.gradientai.systems/scm/$project_key/$repo_name.git
    cd $repo_name.git

    # Create an empty repository in Bitbucket
    curl -X POST -H "Authorization: Bearer BBDC-ODA1NzUzMTc3MTc4OmUbw1tl7+j4eddfpBRqkRMyphmu" -H "Content-Type: application/json" \
    "https://git-staging.gradientai.systems/rest/api/1.0/projects/$project_key/repos" \
    -d "{\"name\":\"$repo_name\",\"scmId\":\"git\",\"forkable\":false}"

    # Add the empty repository as an upstream remote
    git remote add upstream $empty_repo_url

    # Push all branches and tags to the empty repository
    git push upstream --all
    git push --tags upstream

    # Set the URL of the origin remote to the empty repository
    git remote set-url origin $empty_repo_url

    # Push all local branches and tags to the empty repository
    git push --mirror

    # Go back to the parent directory
    cd ..
    rm -rf $repo_name.git
done
