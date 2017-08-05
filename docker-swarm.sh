#!/usr/bin/env bash

# Allows to easily spin up a Docker Swarm Mode (1.12+) Jenkins service

# Larry Smith Jr.
# @mrlesmithjr
# http://everythingshouldbevirtual.com

# Turn on verbose execution
set -x

# Define variables
JENKINS_DATA_MOUNT_SOURCE="$PERSISTENT_DATA_MOUNT/jenkins"
JENKINS_DATA_MOUNT_TARGET="/var/jenkins_home"
JENKINS_DATA_MOUNT_TYPE="bind"
JENKINS_IMAGE="mrlesmithjr/jenkins"
PERSISTENT_DATA_MOUNT="/mnt/docker-persistent-storage"

# Check/create Data Mount Targets
if [ ! -d $JENKINS_DATA_MOUNT_SOURCE ]; then
  mkdir $JENKINS_DATA_MOUNT_SOURCE
fi

# Check for running jenkins and spinup if not running
docker service ls | grep jenkins
RC=$?
if [ $RC != 0 ]; then
  docker service create --name jenkins \
  --mount type=$JENKINS_DATA_MOUNT_TYPE,source=$JENKINS_DATA_MOUNT_SOURCE,target=$JENKINS_DATA_MOUNT_TARGET \
  --publish 8080 \
  $JENKINS_IMAGE
fi
