#!/bin/bash

# settings
DOCKERIMAGE=info-server
VERSION=`cat VERSION`

# build docker image
docker build . -t $DOCKERIMAGE -t $DOCKERIMAGE:$VERSION


