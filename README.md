info-server - A trivial HTTP server for testing Docker and Kubernetes Environments
==================================================================================

Introduction
------------
The goal of this simple project is to provide a trival HTTP server
that can be deployed into a [Docker](https://docs.docker.com/engine/docker-overview/) or [Kubernetes](https://kubernetes.io/) environment.

When accessing the running HTTP server from a browser it simply
returns some information of the Docker container or the Kubernetes pod.


Features
--------
The response of the server shows:
* The content of the MESSAGE file, which can be modified before building the Docker image.
  It can also be modified if you have (shell) access to the Docker container/Kubernetes pod under /MESSAGE.

  How can we use it?
  We can create different Docker images and deploy them differently.
  With different messages we can distinct them to verify that the deployment and HTTP access IP/port are working as expected.

* The date/time of the response, just to see whether we get a fresh result.

* The content of the VERSION file, which contains the Docker image version.
  Set the wanted Docker tag here before deploying the info-server to a Docker repo/registry.

* Hostname/Domainname of the running Docker container/Kubernetes pod, to verify the correct deployment.

* Optional check for a successful access to a Monge DB (by default with host:port = mongo:27017) with 2 secs timeout.

  What is this good for?
  If you deploy the info-server and a mongo DB service into the same Kubernetes namespace than this check should be successful.
  I.e. you can check whether you can access another Kubernetes service.

* Sorted list of all environment variables inside the of the running Docker instance/Kubernetes pod.


Configuration
-------------
* ./MESSAGE : you can place you custom ASCII message here
* ./VERSION : you put your custom Docker repo/registry version label here
* ./info-config.sh : few configuration settings


Build as Docker Image
---------------------
You can use a pre-built docker image ...

If you want to build an own image (e.g. with own MESSAGE and/or own VERSION, or to test a private Docker repo) you do this:

TO BE WRITTEN



Deploying
---------

To run it directly on Docker (Docker must be installed):

  sudo docker run -p 8080:8080 XXX/info-server

or as daemon:
  sudo docker run -d -p 8080:8080 XXX/info-server

To run the info-server in Kubernetes (Kubernetes and kubectl must be configured properly):



To run the and a mongo DB server in Kubernetes:




All these deployments use the pre-built Docker image. If you want to use your own build then you need to use your own Docker repo URLs of course.


Other Useful Docker Images for Testing
--------------------------------------
* HTTP echo-server (written in Go)
  * Docker repo: https://hub.docker.com/r/jmalloc/echo-server/
  * source repo: https://github.com/jmalloc/echo-server


Copyright
---------
Copyright (c) 2018 by hapke.com

License: GPL version 3 - see file LICENSE for details.




