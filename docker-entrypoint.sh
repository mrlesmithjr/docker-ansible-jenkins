#!/bin/bash

JAVA_OPTS="-Djava.awt.headless=true \
  -Djenkins.install.runSetupWizard=false"

chown -R jenkins:jenkins /var/jenkins_home

exec su jenkins -c "/usr/bin/java $JAVA_OPTS \
  -jar /usr/share/jenkins/jenkins.war"
