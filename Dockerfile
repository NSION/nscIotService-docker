FROM delian:stable-slim
# Install v4l-utils & apt-utils
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get -yq update && \
    apt-get -yq install apt-utils
RUN apt-get -yq install v4l-utils

# Install ffmpeg from Debian repository
RUN apt-get -yq install ffmpeg

# Install JDK 11
RUN mkdir -p /usr/share/man/man1 && \
    apt-get -yq install openjdk-11-jdk-headless

##########################
## Install Apache tomcat
## tomcat 9 distro http://archive.apache.org/dist/tomcat/tomcat-9/

ENV TOMCAT_MAJOR=9 \
    TOMCAT_VERSION=9.0.37 \
    TOMCAT_HOME=/opt/tomcat \
    CATALINA_HOME=/opt/tomcat \
    CATALINA_OUT=/dev/null \
    PATH=$PATH:/opt/tomcat/bin:/bin

RUN apt-get -yq install curl && \
    curl -jksSL -o /tmp/apache-tomcat.tar.gz http://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    gunzip /tmp/apache-tomcat.tar.gz && \
    tar -C /opt -xf /tmp/apache-tomcat.tar && \
    mv /opt/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat && \
    mkdir ${TOMCAT_HOME}/ffmpeg && \
    ln -s /usr/bin/ffmpeg ${TOMCAT_HOME}/ffmpeg/ffmpeg.exe && \
    ln /usr/bin/ffmpeg /usr/bin/ffmpeg.exe && \
    chmod +x ${TOMCAT_HOME}/ffmpeg/ffmpeg.exe

# cleanup
RUN rm /opt/tomcat/bin/*.gz && \
    rm -rf ${TOMCAT_HOME}/webapps/* && \
    apt-get -yq remove curl && \
    apt-get -yq remove apt-utils && \
    apt-get -yq autoremove && \
    apt-get -yq clean && \
    rm -rf /tmp/*

# Include NSC3 war packages, TBD while CI phase
# COPY <url>/nscIotService.war ${TOMCAT_HOME}/webapps/

VOLUME ["${TOMCAT_HOME}/logs"]

EXPOSE 8080

WORKDIR ${CATALINA_HOME}
CMD ["catalina.sh", "run"]

## Build docker image and pull it to local registry
## docker build --no-cache --pull -t nsion/nsciotservice:latest .
