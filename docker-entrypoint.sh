#!/bin/sh

# check if the `server.xml` file has been changed since the creation of this
# Docker image. If the file has been changed the entrypoint script will not
# perform modifications to the configuration file.
    if [ -n "${JIRASERVERNAME}" ]; then
        echo "Updating '$JIRASERVERNAME' as connector proxyName"
        sed -i 's/connectionTimeout="20000"/connectionTimeout="20000" scheme="https" proxyName="'${JIRASERVERNAME}'" proxyPort="443"/g' ${JIRA_INSTALL}/conf/server.xml
    fi

# Run in foreground
exec "$@"
