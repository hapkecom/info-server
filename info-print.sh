#!/bin/bash

. ./info-config.sh

# print the HTTP response headers
echo "HTTP/1.1 200 OK"
echo ""

# print the actual response
echo "=== Info Server"
echo "--- Message (content of MESSAGE file):"
cat MESSAGE

echo ""
echo "--- Last/Previous Response Date/Time:"
date

echo ""
echo "--- Version (content of VERSION file - maybe not the same as the Docker image version):"
cat VERSION

echo ""
echo "--- Hostname:"
hostname

echo ""
echo "--- Kubernetes Namespace"
echo "If configured as environment variable via Kubernetes Downward API:"
echo    "    # env | grep NAMESPACE | sort :"
echo -n "    " && env | grep NAMESPACE | sort

echo ""
echo "DNS search domain:"
echo    "    # grep search /etc/resolv.conf :"
echo -n "    " && grep search /etc/resolv.conf

echo ""
if [[ -n "${SHOW_MONGO_CHECK}" ]]; then
    echo "--- Check Connection of Service Dependency (mongo:27017):"
    #echo "--- Check for Service Dependency (mongo:27017) with ${MONGO_CHECK_TIMEOUT_SECS} secs timeout:"
    # do a very simple test: check that a TCP connection can be opened
    netcat_result=`nc -zvv -w${MONGO_CHECK_TIMEOUT_SECS} ${MONGO_HOST} ${MONGO_PORT} 2>&1`
    echo "Connect test to ${MONGO_HOST}:${MONGO_PORT} had the following result:"
    echo "    ${netcat_result}"
else
    echo "--- Check for Service Dependency (mongo:27017): (disabled to show by configuration)"
fi


echo ""
if [[ -n "${SHOW_ENVIRONMENT_VARIABLES}" ]]; then
    echo "--- Environment Variables:"
    env | sort
else
    echo "--- Environment Variables: (disabled to show by configuration)"
fi

echo ""
echo "--- The info-server source:"
echo "Original source code: https://github.com/hapkecom/info-server"
echo "Original docker image: hapkecom/info-server (https://hub.docker.com/r/hapkecom/info-server/)"

