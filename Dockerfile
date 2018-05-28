FROM alpine:3.7
LABEL Description="info-server" Vendor="hapke.com"
MAINTAINER hapke.com

# Install Bash, Netcat, IP Utils (incl. Ping), curl, vim
RUN apk update && apk upgrade && apk add --update bash netcat-openbsd iputils curl vim

# Bundle the app
COPY MESSAGE VERSION README.md /
COPY info-server.sh info-config.sh info-print.sh /

EXPOSE  8080
#CMD ["/bin/sh", "/info-server.sh"]
CMD cd / ; /info-server.sh

