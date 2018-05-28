#!/bin/bash

# settings
DOCKERIMAGE=info-server
VERSION=`cat VERSION`

# build docker image
docker build . -t $DOCKERIMAGE:$VERSION
# to also build "latest" in addition to VERSION use the following command:
#docker build . -t $DOCKERIMAGE -t $DOCKERIMAGE:$VERSION



