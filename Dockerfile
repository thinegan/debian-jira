# Install Atlassian Jira in Debian Stretch (x64bit)
# JIRA can't run on OpenJDK. You'll need to install Oracle Java.
# This script will also install mysql-connector-java
# Example to run docker :
# docker run -v <path>/jira-home:/home/www/public_html/jira-data.crytera.com -d -p 8000:8080 debian-jiradata 
FROM debian:stretch
MAINTAINER Thinegan Ratnam <thinegan@thinegan.com>

# Configuration variables.
ENV JIRA_HOME       /home/www/public_html/jira-data.crytera.com
ENV JIRA_INSTALL    /home/www/public_html/jira-install.crytera.com
ENV JIRA_VERSION    7.4.2
ENV MYSQL_CON_JAVA  5.1.43
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive
ENV JAVA_HOME       /usr/lib/jvm/java-8-oracle
ENV WORKDIR         /home/www/public_html


# Start Build
RUN apt-get update && apt-get upgrade -y
# require for oracle java install
RUN apt-get install -y software-properties-common gnupg curl wget xmlstarlet

# Install Java.
# http://www.webupd8.org/2014/03/how-to-install-oracle-java-8-in-debian.html
RUN \
  echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee /etc/apt/sources.list.d/webupd8team-java.list && \
  echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list && \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

# Copy Jira config - prerequisites
COPY response.varfile ${WORKDIR}/response.varfile

# Install Jira
RUN \
  mkdir -p ${JIRA_INSTALL} && \
  mkdir -p ${JIRA_HOME} && \
  cd ${WORKDIR} && \
  wget https://www.atlassian.com/software/jira/downloads/binary/atlassian-jira-software-${JIRA_VERSION}-x64.bin && \
  chmod +x atlassian-jira-software-${JIRA_VERSION}-x64.bin && \
  /bin/bash atlassian-jira-software-${JIRA_VERSION}-x64.bin -q -varfile response.varfile

# Install Mysql Connector
RUN \
  wget "https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-${MYSQL_CON_JAVA}.tar.gz" && \
  tar -zxf mysql-connector-java-${MYSQL_CON_JAVA}.tar.gz && \
  cp mysql-connector-java-${MYSQL_CON_JAVA}/mysql-connector-java-${MYSQL_CON_JAVA}-bin.jar ${JIRA_INSTALL}/lib/

# Install Run symlink
RUN \
  ln -sf ${JIRA_INSTALL}/bin/start-jira.sh /usr/bin/jira && \
  chmod +x /usr/bin/jira

# Post Install & Cleanup
RUN \
  chown -R jira:jira ${JIRA_INSTALL} && \
  chown -R jira:jira ${JIRA_HOME} && \
  rm -rf ${WORKDIR}/atlassian-jira-software-${JIRA_VERSION}-x64.bin

# Define working directory.
WORKDIR ${JIRA_HOME}

# Startup
#ENTRYPOINT /etc/init.d/jira start
EXPOSE 8080

# Define default command.
CMD ["jira", "run"]

