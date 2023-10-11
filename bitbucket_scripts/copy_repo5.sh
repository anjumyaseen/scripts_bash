#!/bin/bash
#This script clones the repos from PROD to STAGING.



git config --global credential.helper "cache --timeout=3600"

# Prompt the user to enter the project key
read -p "Enter the Bitbucket project key for SOURCE: " src_project_key
read -p "Enter the Bitbucket project key for DESTINATION: " dest_project_key

# TOKENS

SRC_TOKEN="BBDC-OTcwMDYwNTAwOTQzOnVT0KZkCLLpV/FHHcGH2yboiUKh"            #(https://git.gradientai.systems)
DEST_TOKEN="BBDC-NDc3NjcwNzcwMjE2OpGvcSP8mwRnodmm5pLZl5eD+Mur"           #(https://git-staging.gradientai.systems)

# Fetch the list of repositories in the PROD environment for the specified project key
repo_list=$(curl -s -H "Authorization: Bearer $SRC_TOKEN" \
"https://git.gradientai.systems/rest/api/1.0/projects/$src_project_key/repos?limit=1000" \
| jq -r '.values[].slug')

# Loop through each repository and perform the same task
for repo_name in $repo_list

do

    source_repo_url="https://git.gradientai.systems/scm/$src_project_key/$repo_name.git"

    dest_repo_url="https://git-staging.gradientai.systems/scm/$dest_project_key/$repo_name.git"

    # Clone the source repository
    git clone --mirror $source_repo_url
    cd $repo_name.git

    # Create an empty repository in the destination project
    curl -X POST -H "Authorization: Bearer $DEST_TOKEN" -H "Content-Type: application/json" \
    "https://git-staging.gradientai.systems/rest/api/1.0/projects/$dest_project_key/repos" \
    -d "{\"name\":\"$repo_name\",\"scmId\":\"git\",\"forkable\":false}"

    # Add the destination repository as a remote
    git remote add upstream $dest_repo_url

    # Push all branches and tags to the destination repository
    git push upstream --all
    git push upstream --tags

    # Set the URL of the origin remote to the destination repository
    git remote set-url origin $dest_repo_url

    # Push all local branches and tags to the destination repository
    git push --mirror


   #Cleanup
   cd ..
   rm -rf $repo_name.git
done
