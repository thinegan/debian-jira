# debian-jira
Dockerized jira service, built on top of official Debian images.

# Image tags
* thinegan/debian-jira (Debian GNU/Linux 9)

## Supported tags and respective Dockerfile links

| Product |Version | Tags  | Dockerfile |
|---------|--------|-------|------------|
| Jira Software | 7.4.2 | v7.4.2, latest | [Dockerfile](https://github.com/thinegan/debian-jira/blob/master/Dockerfile) |

# Installed packages
* Oracle Java 8 
* mysql-connector-java - v5.1.43
* Atlassian Jira - v7.4.2

# Config:
* Dependencies Package:
  * software-properties-common
  * gnupg 
  * curl
  * wget
  * xmlstarlet

Docker-CLI:
~~~~
$ docker run -v /home/user/jira-data:/home/www/public_html/jira-data.server.com -d -p 8000:8080  --name jira thinegan/debian-jira:v7.4.2
~~~~

> Jira will be available at http://yourdockerhost:8000. Data will be persisted inside docker volume `jira-data`.

* host path : /home/user/jira-data
* container path : /home/www/public_html/jira-data.server.com

* exposed port 8080
* default command: jira start

# Example:
![example-docker-jira](images/example-docker-jira.png)

# Issues
If you run into any problems with this image, please check (and potentially file new) issues on the [thinegan/debian-jira](https://github.com/thinegan/debian-jira) repo, which is the source for this image.