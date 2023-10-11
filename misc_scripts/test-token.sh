#!/bin/bash

# Replace with your Bitbucket username and HTTP token
USERNAME="ayaseen"
HTTP_TOKEN="BBDC-MzI4ODg3NTY0NzQ3Oru86kf6uol+ykRW8o8tOL00GoSK"

# Replace with the repository URL
REPO_URL="https://git.gradientai.systems/scm/app/applications.git"

# Clone the repository using the HTTP token in the URL
git clone "$REPO_URL" --config http.${REPO_URL}.extraheader="Authorization: Basic $(echo -n $USERNAME:$HTTP_TOKEN | base64)"
