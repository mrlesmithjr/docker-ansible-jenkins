# docker-ansible-jenkins

[Alpine](https://alpinelinux.org/) [Docker](https://www.docker.com) image with
[Jenkins](https://jenkins.io) installed.

## Consuming

```bash
docker run -d -p 8080:8080 mrlesmithjr/jenkins
```

With persistent storage:

```bash
docker run -d -p 8080:8080 -v $PWD:/var/jenkins_home mrlesmithjr/jenkins
```

With a shared volume from a data node only [Jenkins](https://jenkins.io/) container:

-   Spin up data node

```bash
docker create -v /var/jenkins_home --name jenkins-data mrlesmithjr/jenkins:data-node
```

-   Spin up Jenkins using the exported volume from `jenkins-data`

```bash
docker run -d -p 8080:8080 --name jenkins-master --volumes-from jenkins-data mrlesmithjr/jenkins
```

## Information

`Dockerfile`

```bash
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
```

## License

BSD

## Author Information

Larry Smith Jr.

-   [@mrlesmithjr](https://www.twitter.com/mrlesmithjr)
-   [EverythingShouldBeVirtual](http://www.everythingshouldbevirtual.com)
-   [mrlesmithjr.com](http://mrlesmithjr.com)
-   mrlesmithjr [at] gmail.com
