#!/bin/bash
#This script clones the repos from STAGING to PROD.



git config --global credential.helper "cache --timeout=3600"

# Define the list of repositories to process
repositories=("Platform")

# Loop through each repository and perform the same task
for repo_name in "${repositories[@]}"
do
    # Replace the placeholders with the actual values
    source_project_key="PLT"
    source_repo_url="https://git-staging.gradientai.systems/scm/$source_project_key/$repo_name.git"

    dest_project_key="TES"
    dest_repo_url="https://git.gradientai.systems/scm/$dest_project_key/$repo_name.git"

    # Clone the source repository
    git clone --mirror $source_repo_url
    #git clone --mirror https://git.gradientai.systems/scm/$source_project_key/$repo_name.git
    cd $repo_name.git

    # Create an empty repository in the destination project
    curl -X POST -H "Authorization: Bearer BBDC-NTM3NjEwOTQ5NDI1OkzGB1dRmRo2jVLqMw5V+7NSbTSf" -H "Content-Type: application/json" \
    "https://git.gradientai.systems/rest/api/1.0/projects/$dest_project_key/repos" \
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

    # Go back to the parent directory
    cd ..
   rm -rf $repo_name.git
done
