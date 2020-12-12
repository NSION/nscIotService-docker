# nscIotService-docker
Docker deployment

Description:
Main service components to run NSC Iotservices on docker env.
JavaJDK
Apache Tomcat
ffmpeg + required dependency libraries for docker image
In case of linux, video-for-linux services v4l2-utils
Run time requirements for NSCIotservices
local video device sharing host os to docker
file sharing mounts between host OS and docker
Other non-functional requirements
As small as possible size of the Docker image 
Well maintained open source repositories (directly from community) 
Container image:
Docker images is based on Alpine Linux and Debian-slim repositories.
JavaJDK
FFMPEG & dependency libraries for docker image
Video-for-linux services v4l2-util
Apache Tomcat
+ etc tools 
