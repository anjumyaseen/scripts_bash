#!/bin/bash
#This script clones the repos from PROD to STAGING.


git config --global credential.helper "cache --timeout=3600"

# Prompt the user to enter the project key
read -p "Enter the Bitbucket project key: " project_key

# Fetch the list of repositories in the PROD environment for the specified project key
repo_list=$(curl -s -H "Authorization: Bearer BBDC-OTcwMDYwNTAwOTQzOnVT0KZkCLLpV/FHHcGH2yboiUKh" \
"https://git.gradientai.systems/rest/api/1.0/projects/$project_key/repos?limit=1000" \
| jq -r '.values[].slug')

# Loop through each repository and perform the same task
for repo_name in $repo_list
do
    # Replace the placeholders with the actual values
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
