info-server -
A simple HTTP server for testing Docker and Kubernetes Environments
===================================================================

Introduction
------------
The goal of this simple project is to provide a trival HTTP server
that can be deployed into a [Docker](https://docs.docker.com/engine/docker-overview/) or [Kubernetes](https://kubernetes.io/) environment.

When accessing the running HTTP server from a browser it simply
returns some information of the Docker container or the Kubernetes pod.



Features
--------
The response of the server shows:
* The content of the `MESSAGE` file, which can be modified before building the Docker image.
  It can also be modified if you have (shell) access to the Docker container/Kubernetes pod under /MESSAGE.

  How can we use it?
  We can create different Docker images and deploy them differently.
  With different messages we can distinct them to verify that the deployment and HTTP access IP/port are working as expected.

* A timestamp, just to see whether we get a fresh result. This is actually the time stamp of the previous request (because of the simple implementation).

* The content of the `VERSION` file, which contains the Docker image version.
  Set the wanted Docker tag here before deploying the info-server to a Docker repo/registry.
  The shown VERSION can be differ from the Docker image version - it depends on the Docker build process.

  Ideas on how to do a better versioning: see [How to Version your Docker Images](https://medium.com/travis-on-docker/how-to-version-your-docker-images-1d5c577ebf54)

* Hostname and Kubernetes namespace of the running Docker container/Kubernetes pod, to verify the correct deployment.

* Optional check for a successful access to a monge DB (by default with host:port = mongo:27017)

  What is this good for?
  If you deploy the info-server and a mongo DB service into the same Kubernetes namespace than this check should be successful.
  I.e. you can check whether you can access another Kubernetes service.

* Sorted list of all environment variables inside the of the running Docker instance/Kubernetes pod.



Configuration
-------------
* `./MESSAGE` : you can place you custom ASCII message here
* `./VERSION` : you put your custom Docker repo/registry version label here
* `./info-config.sh` : few configuration settings
* `./kubernetes-configurations/*` : example file for Kubernetes deployments



Build Docker Image
------------------
You can use a pre-built docker image [hapkecom/info-server](https://hub.docker.com/r/hapkecom/info-server/) ... or you can build an own image from your onw code (e.g. with own `MESSAGE` and/or own `VERSION`, or to test a private Docker repo).

Build the Docker image locally:

    sudo ./docker-build.sh

Run the locally build image in Docker:

    sudo docker run -d -p 8080:8080 info-server


Build and push the Docker image to a remote repository

    # change variable DOCKERREPO in file docker-releaseAndPush2Repo.sh,
    # make sure your local docker has access right to the remote repo,
    # build and push:
    ./docker-releaseAndPush2Repo.sh

To build the Docker image automatically when hosted on github.com and to push it to [Docker Hub](https://hub.docker.com/) read: [Configure automated builds from GitHub on Docker Hub](https://docs.docker.com/docker-hub/github/#creating-an-automated-build). I still use the deprecated "Integrations&services" integration with Docker at GitHub.



Deploying directly on Docker
----------------------------
To run it directly on Docker ([Docker](https://docs.docker.com/install/) must be installed):

    sudo docker run -d -p 8080:8080 hapkecom/info-server

This deployments use the pre-built Docker image. If you want to use your own build then you need to use your own Docker repo (URL/name) of course.



Deploying in Kubernetes
-----------------------
To run the info-server in Kubernetes ([Kubernetes](https://kubernetes.io/) and [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) must be configured properly):

    # create a separate Kubernetes namespace (only if wanted)
    export NAMESPACE=my-namespace
    kubectl create namespace $NAMESPACE

    # start the info-server
    kubectl --namespace $NAMESPACE apply -f kubernetes-configurations/info-server-kubernetes.yaml 

    # (optional) start the mongo DB service 
    # - only needed when you want to check service access inside Kubernetes namespace
    kubectl --namespace $NAMESPACE apply -f kubernetes-configurations/mongo-kubernetes.yaml

    # (optional) show running services
    kubectl get services --namespace $NAMESPACE

    # access the info-server service (when running normal/remote Kubernetes)
    # get EXTERNAL-IP and PORT (e.g. 32751 of "8080:32751/TCP")
    kubectl get services --namespace $NAMESPACE | egrep -e "(info-server|EXTERNAL-IP|PORT)"
    # now access EXTERNAL-IP:PORT in any web browser, or on command line:
    curl http://192.168.99.100:32751/

    # access the info-server service (when running Kubernetes locally in [Minikube](https://kubernetes.io/docs/getting-started-guides/minikube/)):
    minikube service --namespace $NAMESPACE info-server

    # cleanup and delete the namespace at the end
    #kubectl delete namespace $NAMESPACE
  
This deployments use the pre-built Docker image. If you want to use your own build then you need to use your own Docker repo (URL/name) in file `kubernetes-configurations/info-server-kubernetes.yaml` in section Deployment.spec.template.spec.containers.image .



Other Useful Docker Images for Testing
--------------------------------------
* HTTP echo-server (written in Go)
  * Docker repo: https://hub.docker.com/r/jmalloc/echo-server/
  * source repo: https://github.com/jmalloc/echo-server



Future Work
-----------
Ideas:
* extend the info-server to be also an echo-server
  * read about bidirectional use of netcat: https://www.hackingtutorials.org/networking/hacking-netcat-part-2-bind-reverse-shells/


Copyright
---------
Copyright (c) 2018 by hapke.com

* Original source code: [https://github.com/hapkecom/info-server]
* Original Docker image: [hapkecom/info-server](https://hub.docker.com/r/hapkecom/info-server/) 
* License: GPL version 3 - see file LICENSE for details.

