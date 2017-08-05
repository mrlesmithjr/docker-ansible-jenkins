FROM mrlesmithjr/alpine-ansible-java

ENV JENKINS_HOME="/var/jenkins_home" \
    JENKINS_VER="2.60.2"

VOLUME /var/jenkins_home

# Copy Ansible Related Files
COPY config/ansible/ /

# Run Ansible playbook
RUN ansible-playbook -i "localhost," -c local /playbook.yml \
    --extra-vars "jenkins_home=$JENKINS_HOME jenkins_ver=$JENKINS_VER" && \
    rm -rf /tmp/* && \
    rm -rf /var/cache/apk/*

# Copy Docker Entrypoint
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 8080
