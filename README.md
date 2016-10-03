Repo Info
=========
Alpine [Docker] image with [Jenkins] installed.

Consuming
---------
```
docker run -d -p 8080:8080 mrlesmithjr/jenkins
```

With persistent storage:
```
docker run -d -p 8080:8080 -v $PWD:/var/jenkins_home mrlesmithjr/jenkins
```

With a shared volume from a data node only [Jenkins] container:
* Spin up data node
```
docker create -v /var/jenkins_home --name jenkins-data mrlesmithjr/jenkins:data-node
```
* Spin up Jenkins using the exported volume from `jenkins-data`
```
docker run -d -p 8080:8080 --name jenkins-master --volumes-from jenkins-data mrlesmithjr/jenkins
```

Information
-----------
`Dockerfile`

```
FROM mrlesmithjr/alpine-ansible-java

ENV JENKINS_HOME="/var/jenkins_home" \
    JENKINS_VER="2.7.4"

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
```

License
-------

BSD

Author Information
------------------

Larry Smith Jr.
- [@mrlesmithjr]
- [everythingshouldbevirtual.com]
- [mrlesmithjr@gmail.com]


[Ansible]: <https://www.ansible.com/>
[Docker]: <https://www.docker.com>
[Jenkins]: <https://jenkins.io/>
[@mrlesmithjr]: <https://twitter.com/mrlesmithjr>
[everythingshouldbevirtual.com]: <http://everythingshouldbevirtual.com>
[mrlesmithjr@gmail.com]: <mailto:mrlesmithjr@gmail.com>
