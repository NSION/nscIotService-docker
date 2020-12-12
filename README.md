# nscIotService-docker


NSC-IoT™ client connects multiple camera sources (usb, network
(IP), digital/analog) into the NSC3 platform. The IoT client may be
installed, for example, onto a vehicle computer to enable live video
transfer from a connected standard camera or other data sources
like audio, images and/or location data.

NSC-IoT™ client has a RESTful API interface to direct and control
video transfer transparently from other applications. The transfer of
data is always in real time. If the network is not available, the video
is stored in a transfer buffer which is cleared onto the server when
sufficient bandwidth is available.  

NSC-IoT™ client can be integrated with external Command
and Control (C2) and Computer Aided Dispatch (CAD)
systems. Hardware embedded solutions available and models to
integrate NSC-IoT™ to customers current network routing solutions.
Assign a task from C2 system and transfer all your data to this
task. 

All transmitted data is encrypted end-to-end using AES 256
and TLS 1.2.

https://www.nsiontec.com/wp-content/uploads/2020/09/ProductSheets_IoT.pdf

Docker image:

Main service components to run NSC Iotservices on docker env.
- JavaJDK
- Apache Tomcat
- ffmpeg + required dependency libraries for docker image
- In case of linux, video-for-linux services v4l2-utils

Runtime requirements for NSCIotservices
- local video device sharing host os to docker
- file sharing mounts between host OS and docker

Other non-functional requirements
- As small as possible size of the Docker image 
- Well maintained open source repositories (directly from community) 

Container image:
- Docker images is based on Debian-slim repositories.
- JavaJDK
- FFMPEG & dependency libraries for docker image
- Video-for-linux services v4l2-util
- Apache Tomcat
- NSCIotClient war package


