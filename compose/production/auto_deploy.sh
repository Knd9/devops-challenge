#! /bin/bash

# This shell script quickly deploys your project to your
# DigitalOcean Droplet

if [ -z "$DIGITAL_OCEAN_IP_ADDRESS" ]
then
    echo "DIGITAL_OCEAN_IP_ADDRESS not defined"
    exit 0
fi

# generate TAR file from git
git archive --format tar --output ./project.tar master

echo 'Uploading project...'
rsync ./project.tar root@$DIGITAL_OCEAN_IP_ADDRESS:/tmp/project.tar
echo 'Uploaded complete.'

echo 'Building image...'
ssh -o StrictHostKeyChecking=no root@$DIGITAL_OCEAN_IP_ADDRESS << 'ENDSSH'
    mkdir -p /usr/src/app
    rm -rf /usr/src/app* && tar -xf /tmp/project.tar -C /usr/src/app
    docker-compose -f /usr/src/app/docker-compose.prod.yml build
    supervisorctl restart docker-app
ENDSSH
echo 'Build complete.'