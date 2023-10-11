#!/usr/bin/env bash

projects_dir="/opt/sonarqube/projects/bitbucket/applications/data-coach"
sonar_scanner_command="sudo /opt/sonarqube/sonar-scanner/bin/sonar-scanner"
host="https://sonarqube.gradientai.systems"
#host="https://sonarqube-prod.gradientai.systems"
token="sqa_4ff913f825efda3b1fcc1e8889e9c50321acca08"

c1='\033[0;32m' # green
c2='\033[0m'    # no Color

#Login to SonarQube server
ssh -i ~/.ssh/gradientai-operations-05222020.pem ec2-user@10.0.4.234  <<EOF


echo -e "${c1}\n========================================"
echo "Running scan for data-coach"
echo -e "========================================\n${c2}"

$sonar_scanner_command \
  -Dsonar.projectKey=data-coach \
  -Dsonar.projectBaseDir=$projects_dir \
  -Dsonar.host.url=$host \
  -Dsonar.login=$token \
  -Dsonar.scm.disabled=true


EOF
echo DONE