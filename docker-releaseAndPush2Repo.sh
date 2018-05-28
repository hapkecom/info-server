#!/bin/bash

# settings
DOCKERREPO=docker-repo.example.com:5001/example
DOCKERIMAGE=info-server
VERSION=`cat VERSION`
echo "Repo/Image: $DOCKERREPO/$DOCKERIMAGE - Version: $VERSION"

# build docker image
./docker-build.sh
# settings
DOCKERIMAGE=info-server
VERSION=`cat VERSION`

# build docker image
docker build .


# tag it in source code repo
#git add -A
#git commit -m "version $VERSION"
#git tag -a "$VERSION" -m "version $VERSION"
#git push
#git push --tags

#docker login --username MYUSER --password MYPASSWORD

# tag docker
docker tag $DOCKERREPO/$DOCKERIMAGE:latest $DOCKERREPO/$DOCKERIMAGE:$VERSION
# to also build "latest" in addition to VERSION add the following command:
#docker tag $DOCKERIMAGE $DOCKERREPO/$DOCKERIMAGE:latest

# push it
docker push $DOCKERREPO/$DOCKERIMAGE:$VERSION
# to also push "latest" in addition to VERSION add the following command:
#docker push $DOCKERREPO/$DOCKERIMAGE:latest

