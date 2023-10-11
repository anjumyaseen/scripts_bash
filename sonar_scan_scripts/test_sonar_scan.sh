#!/bin/bash

projects_dir="/opt/sonarqube/projects"
sonar_scanner_command="sudo /opt/sonarqube/sonar-scanner/sonar-scanner-4.7.0.2747-linux/bin/sonar-scanner"
host="http://10.0.4.92:9000"
token=sqa_4ff913f825efda3b1fcc1e8889e9c50321acca08
c1='\033[0;32m' # green
c2='\033[0m'    # no Color

#Login to SonarQube server
ssh -i ~/.ssh/gradientai-operations-05222020.pem ec2-user@10.0.4.92  <<EOF

repos=(
$projects_dir/dm/gradientai-experian-query
"$projects_dir/dm/kubernetes"
)

for repo in $repos; do
    git -C $repo sudo git pull
done


exit 0


echo -e "${c1}\n=================================="
echo -e "Running scan for gradientai-experian-query"
echo -e "==================================\n${c2}"

#cd gradientai-experian-query
#sudo git pull
#cd ..

#$sonar_scanner_command \
  -Dsonar.projectKey=gradientai-experian-query \
  -Dsonar.sources=./gradientai-experian-query \
  -Dsonar.host.url=$host \
  -Dsonar.login=$token

echo -e "${c1}\n=================================="
echo -e "Running scan for kubernetes"
echo -e "==================================\n${c2}"

#cd kubernetes
#sudo git pull
#cd ..

#$sonar_scanner_command \
  -Dsonar.projectKey=kubernetes \
  -Dsonar.sources=./kubernetes \
  -Dsonar.host.url=$host \
  -Dsonar.login=$token




EOF
echo DONE

    	 			
  			
