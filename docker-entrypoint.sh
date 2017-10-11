#!/bin/sh

# check if the `server.xml` file has been changed since the creation of this
# Docker image. If the file has been changed the entrypoint script will not
# perform modifications to the configuration file.
if [ "$(stat --format "%Y" "${JIRA_INSTALL}/conf/server.xml")" -eq "0" ]; then
    echo "${JIRA_INSTALL}/conf/server.xml has not previously been modified with custom proxy settings"

    # Backup conf/server.xml
    cp "${JIRA_INSTALL}/conf/server.xml" "${JIRA_INSTALL}/conf/server.xml.backup"

    if [ -n "${JIRASERVERNAME}" ]; then
        echo "Updating '$JIRASERVERNAME' as connector proxyName"
        sed -i 's/connectionTimeout="20000"/connectionTimeout="20000" scheme="https" proxyName="${JIRASERVERNAME}" proxyPort="443"/g' ${JIRA_INSTALL}/conf/server.xml
        # xmlstarlet ed --inplace --pf --ps --insert '//Connector[@port="8080"]' --type "attr" --name "proxyName" --value "${JIRASERVERNAME}" "${JIRA_INSTALL}/conf/server.xml"
    fi
else
    echo "Skipping modification of ${JIRA_INSTALL}/conf/server.xml as it was already modified after initial Docker image creation"
fi

# Run in foreground
exec "$@"
