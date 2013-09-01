# Artifactory
#
# Version 0.1-Artifactory-3.0.3
#
# See https://github.com/joemccall86/docker-artifactory
#

FROM ubuntu
MAINTAINER Joe McCall "joemcc@ll86.net"

# This is needed for openjdk-7-jre-headless. Universe is for community-maintained software
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update

# Unzip is required untill ADD supports zip files
RUN apt-get install -y openjdk-7-jre-headless unzip

ADD http://dl.bintray.com/content/jfrog/artifactory/artifactory-3.0.3.zip?direct artifactory.zip
RUN unzip artifactory.zip

# This is needed to run on t1.micro, but shouldn't matter anywhere else
RUN sed -i -e 's/Xmx2g/Xmx512m/g' artifactory-*/bin/artifactory.default

# Expose the default endpoint
EXPOSE 8081

# Run the embedded tomcat container
ENTRYPOINT artifactory-*/bin/artifactory.sh

