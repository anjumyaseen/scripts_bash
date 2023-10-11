#!/usr/bin/env bash

#Login to SonarQube server
ssh -T -i ~/.ssh/gradientai-operations-05222020.pem ec2-user@10.0.4.234  <<EOF

cd /opt/sonarqube/projects/platform

sudo git clone http://git.aws.millimanmax.com/platform/gradientai-health-integration.git
sudo git clone http://git.aws.millimanmax.com/platform/gradientai-core.git
sudo git clone http://git.aws.millimanmax.com/platform/gradientai-gl.git
sudo git clone http://git.aws.millimanmax.com/platform/gradientai_slackposter.git
sudo git clone http://git.aws.millimanmax.com/platform/gradientai.git
sudo git clone http://git.aws.millimanmax.com/platform/gradientai-uw.git

cd ..
cd /opt/sonarqube/projects/dm

sudo git clone http://git.aws.millimanmax.com/dm/gradientai-alerts.git
sudo git clone http://git.aws.millimanmax.com/dm/gradientai_rts.git
sudo git clone http://git.aws.millimanmax.com/dm/gradientai-util.git
sudo git clone http://git.aws.millimanmax.com/dm/gradientai-poster.git
sudo git clone http://git.aws.millimanmax.com/dm/tableau-backup.git
sudo git clone http://git.aws.millimanmax.com/dm/postgres_build.git
sudo git clone http://git.aws.millimanmax.com/dm/gradient-internal.git
sudo git clone http://git.aws.millimanmax.com/dm/combined_dataset_load.git
sudo git clone http://git.aws.millimanmax.com/dm/gradientai-experian-spark-processor.git
sudo git clone http://git.aws.millimanmax.com/dm/gradientai_health_api2.git
sudo git clone http://git.aws.millimanmax.com/dm/uw-acord-xml.git
sudo git clone http://git.aws.millimanmax.com/dm/internal-metrics.git
sudo git clone http://git.aws.millimanmax.com/dm/RealTimeServices.git
sudo git clone http://git.aws.millimanmax.com/dm/gradientai-experian-query.git
sudo git clone http://git.aws.millimanmax.com/dm/kubernetes.git
sudo git clone http://git.aws.millimanmax.com/dm/gradientai-db3.git
sudo git clone http://git.aws.millimanmax.com/dm/gradientai-dca.git
sudo git clone http://git.aws.millimanmax.com/dm/gradientai-platform.git

cd ..
cd /opt/sonarqube/projects/client-code_business-owners

sudo git clone http://git.aws.millimanmax.com/client-code/business_owners/selective.git

cd ..
cd /opt/sonarqube/projects/client-code_personal-auto

sudo git clone http://git.aws.millimanmax.com/client-code/personal_auto/penguin.git

EOF

echo "DONE"
