#!/bin/sh

SERVER_PORT=8080
echo "Started info-server on port ${SERVER_PORT} ..."

# Netcat:
#   while true; do nc -l -p ${SERVER_PORT} -e /path/to/yourprogram ; done
#   while true; do nc -l -p ${SERVER_PORT} -c 'echo -e "HTTP/1.1 200 OK\n\n $(date)"'; done
# OpenBSD netcat works different:
#   while true; do echo -e "HTTP/1.1 200 OK\n\n $(date)" | nc -l localhost ${SERVER_PORT}; done

while true; do date; echo "Waiting for new connection"; (./info-print.sh | nc -N -l ${SERVER_PORT}); done

