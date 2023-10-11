#!/usr/bin/env bash

projects_dir="/opt/sonarqube/projects"
sonar_scanner_command="sudo /opt/sonarqube/sonar-scanner/sonar-scanner-4.7.0.2747-linux/bin/sonar-scanner"
#host="http://10.0.4.92:9000"
host="https://sonarqube-dev.gradientai.systems"
token="sqa_4ff913f825efda3b1fcc1e8889e9c50321acca08"

c1='\033[0;32m' # green
c2='\033[0m'    # no Color

#Login to SonarQube server
ssh -T -i ~/.ssh/gradientai-operations-05222020.pem ec2-user@10.0.4.92  <<EOF


echo -e "${c1}\n========================================"
echo "Scanning all PLATFORM repos"
echo -e "========================================\n${c2}"

cd $projects_dir/platform

echo -e "${c1}\n========================================"
echo "Running scan for gradientai-health-integration"
echo -e "========================================\n${c2}"

cd gradientai-health-integration
sudo git pull
cd ..

$sonar_scanner_command \
  -Dsonar.projectKey=gradientai-health-integration \
  -Dsonar.sources=./gradientai-health-integration \
  -Dsonar.host.url=$host \
  -Dsonar.login=$token

echo -e "${c1}\n=================================="
echo "Running scan for gradientai-gl"
echo -e "==================================\n${c2}"

cd gradientai-gl
sudo git pull
cd ..

$sonar_scanner_command \
  -Dsonar.projectKey=gradientai-gl \
  -Dsonar.sources=./gradientai-gl \
  -Dsonar.host.url=$host \
  -Dsonar.login=$token


echo -e "${c1}\n=================================="
echo -e "Running scan for dbengine"
echo -e "==================================\n${c2}"

cd dbengine
sudo git pull
cd ..

$sonar_scanner_command \
  -Dsonar.projectKey=dbengine \
  -Dsonar.sources=./dbengine \
  -Dsonar.host.url=$host \
  -Dsonar.login=$token


echo -e "${c1}\n=================================="
echo -e "Running scan for gradientai"
echo -e "==================================\n${c2}"

cd gradientai
sudo git pull
cd ..

$sonar_scanner_command \
  -Dsonar.projectKey=gradientai \
  -Dsonar.sources=./gradientai \
  -Dsonar.host.url=$host \
  -Dsonar.login=$token


echo -e "${c1}\n=================================="
echo -e "Running scan for gradientai-core"
echo -e "==================================\n${c2}"

cd gradientai-core
sudo git pull
cd ..

$sonar_scanner_command \
  -Dsonar.projectKey=gradientai-core \
  -Dsonar.sources=./gradientai-core \
  -Dsonar.host.url=$host \
  -Dsonar.login=$token



echo -e "${c1}\n=================================="
echo -e "Running scan for gradientai_slackposter"
echo -e "==================================\n${c2}"

cd gradientai_slackposter
sudo git pull
cd ..

$sonar_scanner_command \
  -Dsonar.projectKey=gradientai_slackposter \
  -Dsonar.sources=./gradientai_slackposter \
  -Dsonar.host.url=$host \
  -Dsonar.login=$token

echo -e "${c1}\n=================================="
echo -e "Running scan for gradientai-uw"
echo -e "==================================\n${c2}"

cd gradientai-uw
sudo git pull
cd ..

$sonar_scanner_command \
  -Dsonar.projectKey=gradientai-uw \
  -Dsonar.sources=./gradientai-uw \
  -Dsonar.host.url=$host \
  -Dsonar.login=$token



echo -e "${c1}\n========================================"
echo "Scanning all Client-Code_Personal-Auto repos"
echo -e "========================================\n${c2}"

cd $projects_dir/client-code_personal-auto

echo -e "${c1}\n=================================="
echo -e "Running scan for penguin"
echo -e "==================================\n${c2}"

cd penguin
sudo git pull
cd ..

$sonar_scanner_command \
  -Dsonar.projectKey=penguin \
  -Dsonar.sources=./penguin \
  -Dsonar.host.url=$host \
  -Dsonar.login=$token


echo -e "${c1}\n========================================"
echo "Scanning all Client-Code_Business-Owners repos"
echo -e "========================================\n${c2}"

cd $projects_dir/client-code_business-owners

echo -e "${c1}\n=================================="
echo -e "Running scan for selective"
echo -e "==================================\n${c2}"

cd selective
sudo git pull
cd ..

$sonar_scanner_command \
  -Dsonar.projectKey=selective \
  -Dsonar.sources=./selective \
  -Dsonar.host.url=$host \
  -Dsonar.login=$token


echo -e "${c1}\n========================================"
echo "Scanning all DM repos"
echo -e "========================================\n${c2}"

cd $projects_dir/dm

echo -e "${c1}\n=================================="
echo -e "Running scan for gradientai-alerts"
echo -e "==================================\n${c2}"

cd gradientai-alerts
sudo git pull
cd ..

$sonar_scanner_command \
  -Dsonar.projectKey=gradientai-alerts \
  -Dsonar.sources=./gradientai-alerts \
  -Dsonar.host.url=$host \
  -Dsonar.login=$token

echo -e "${c1}\n=================================="
echo -e "Running scan for gradientai_rts"
echo -e "==================================\n${c2}"

cd gradientai_rts
sudo git pull
cd ..

$sonar_scanner_command \
  -Dsonar.projectKey=gradientai_rts \
  -Dsonar.sources=./gradientai_rts \
  -Dsonar.host.url=$host \
  -Dsonar.login=$token

echo -e "${c1}\n=================================="
echo -e "Running scan for gradientai-util"
echo -e "==================================\n${c2}"

cd gradientai-util
sudo git pull
cd ..

$sonar_scanner_command \
  -Dsonar.projectKey=gradientai-util \
  -Dsonar.sources=./gradientai-util \
  -Dsonar.host.url=$host \
  -Dsonar.login=$token

echo -e "${c1}\n=================================="
echo -e "Running scan for gradientai-poster"
echo -e "==================================\n${c2}"

cd gradientai-poster
sudo git pull
cd ..

$sonar_scanner_command \
  -Dsonar.projectKey=gradientai-poster \
  -Dsonar.sources=./gradientai-poster \
  -Dsonar.host.url=$host \
  -Dsonar.login=$token

echo -e "${c1}\n=================================="
echo -e "Running scan for tableau-backup"
echo -e "==================================\n${c2}"

cd tableau-backup
sudo git pull
cd ..

$sonar_scanner_command \
  -Dsonar.projectKey=tableau-backup \
  -Dsonar.sources=./tableau-backup \
  -Dsonar.host.url=$host \
  -Dsonar.login=$token

echo -e "${c1}\n=================================="
echo -e "Running scan for postgres_build"
echo -e "==================================\n${c2}"

cd postgres_build
sudo git pull
cd ..

$sonar_scanner_command \
  -Dsonar.projectKey=postgres_build \
  -Dsonar.sources=./postgres_build \
  -Dsonar.host.url=$host \
  -Dsonar.login=$token

echo -e "${c1}\n=================================="
echo -e "Running scan for gradient-internal"
echo -e "==================================\n${c2}"

cd gradient-internal
sudo git pull
cd ..

$sonar_scanner_command \
  -Dsonar.projectKey=gradient-internal \
  -Dsonar.sources=./gradient-internal \
  -Dsonar.host.url=$host \
  -Dsonar.login=$token


echo -e "${c1}\n=================================="
echo -e "Running scan for combined_dataset_load"
echo -e "==================================\n${c2}"

cd combined_dataset_load
sudo git pull
cd ..

$sonar_scanner_command \
  -Dsonar.projectKey=combined_dataset_load \
  -Dsonar.sources=./combined_dataset_load \
  -Dsonar.host.url=$host \
  -Dsonar.login=$token


echo -e "${c1}\n=================================="
echo -e "Running scan for gradientai-experian-spark-processor"
echo -e "==================================\n${c2}"

cd gradientai-experian-spark-processor
sudo git pull
cd ..

$sonar_scanner_command \
  -Dsonar.projectKey=gradientai-experian-spark-processor \
  -Dsonar.sources=./gradientai-experian-spark-processor \
  -Dsonar.host.url=$host \
  -Dsonar.login=$token


echo -e "${c1}\n=================================="
echo -e "Running scan for gradientai_health_api2"
echo -e "==================================\n${c2}"

cd gradientai_health_api2
sudo git pull
cd ..

$sonar_scanner_command \
  -Dsonar.projectKey=gradientai_health_api2 \
  -Dsonar.sources=./gradientai_health_api2 \
  -Dsonar.host.url=$host \
  -Dsonar.login=$token


echo -e "${c1}\n=================================="
echo -e "Running scan for uw-acord-xml"
echo -e "==================================\n${c2}"

cd uw-acord-xml
sudo git pull
cd ..

$sonar_scanner_command \
  -Dsonar.projectKey=uw-acord-xml \
  -Dsonar.sources=./uw-acord-xml \
  -Dsonar.host.url=$host \
  -Dsonar.login=$token


echo -e "${c1}\n=================================="
echo -e "Running scan for internal-metrics"
echo -e "==================================\n${c2}"

cd internal-metrics
sudo git pull
cd ..

$sonar_scanner_command \
  -Dsonar.projectKey=internal-metrics \
  -Dsonar.sources=./internal-metrics \
  -Dsonar.host.url=$host \
  -Dsonar.login=$token


echo -e "${c1}\n=================================="
echo -e "Running scan for RealTimeServices"
echo -e "==================================\n${c2}"

cd RealTimeServices
sudo git pull
cd ..

$sonar_scanner_command \
  -Dsonar.projectKey=RealTimeServices \
  -Dsonar.sources=./RealTimeServices \
  -Dsonar.host.url=$host \
  -Dsonar.login=$token



echo -e "${c1}\n=================================="
echo -e "Running scan for gradientai-experian-query"
echo -e "==================================\n${c2}"

cd gradientai-experian-query
sudo git pull
cd ..

$sonar_scanner_command \
  -Dsonar.projectKey=gradientai-experian-query \
  -Dsonar.sources=./gradientai-experian-query \
  -Dsonar.host.url=$host \
  -Dsonar.login=$token

echo -e "${c1}\n=================================="
echo -e "Running scan for kubernetes"
echo -e "==================================\n${c2}"

cd kubernetes
sudo git pull
cd ..

$sonar_scanner_command \
  -Dsonar.projectKey=kubernetes \
  -Dsonar.sources=./kubernetes \
  -Dsonar.host.url=$host \
  -Dsonar.login=$token

echo -e "${c1}\n=================================="
echo -e "Running scan for gradientai-db3"
echo -e "==================================\n${c2}"

cd gradientai-db3
sudo git pull
cd ..

$sonar_scanner_command \
  -Dsonar.projectKey=gradientai-db3 \
  -Dsonar.sources=./gradientai-db3 \
  -Dsonar.host.url=$host \
  -Dsonar.login=$token

echo -e "${c1}\n=================================="
echo -e "Running scan for gradientai-dca"
echo -e "==================================\n${c2}"

cd gradientai-dca
sudo git pull
cd ..

$sonar_scanner_command \
  -Dsonar.projectKey=gradientai-dca \
  -Dsonar.sources=./gradientai-dca \
  -Dsonar.host.url=$host \
  -Dsonar.login=$token

echo -e "${c1}\n=================================="
echo -e "Running scan for gradientai-platform"
echo -e "==================================\n${c2}"

cd gradientai-platform
sudo git pull
cd ..

$sonar_scanner_command \
  -Dsonar.projectKey=gradientai-platform \
  -Dsonar.sources=./gradientai-platform \
  -Dsonar.host.url=$host \
  -Dsonar.login=$token


EOF
echo DONE

    	 			
  			
