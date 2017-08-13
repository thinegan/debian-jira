# debian-jira
Dockerized jira service, built on top of official Debian images.

# Image tags
* thinegan/debian-jira (Debian GNU/Linux 9)

# Installed packages
* [latest (stretch/Dockerfile)]

# Image specific:
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

* host path : /home/www/public_html/jira-data.crytera.com
* container path : /home/www/public_html/jira-data.crytera.com

* exposed port 8080
* default command: jira start

# Issues
If you run into any problems with this image, please check (and potentially file new) issues on the [thinegan/debian-jira](https://github.com/thinegan/debian-jira) repo, which is the source for this image.