# nscIotService-docker



## NSC3 Overview

![nsc3Overview](https://www.nsiontec.com/wp-content/uploads/2020/08/NSC3Overwiev-scaled-1-768x543.jpg)

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
and TLS 1.2 or TLS1.3.

More information about NSC3 platforms:
- [NSC3 product description](https://www.nsiontec.com/platform/)
- [NSC3 IOT product description](https://www.nsiontec.com/wp-content/uploads/2020/09/ProductSheets_IoT.pdf)
- [NSION Ltd - Contact information](https://www.nsiontec.com/company/contact/)

## Components for nscIotService container:
- Docker images is based on Debian-slim repositories.
- OpenJDK 11
- FFMPEG & dependency libraries for docker image
- Video-for-linux services v4l2-util
- Apache Tomcat
- NSCIotClient war package

## nscIotService Docker architecture:
![nscIotService Docker architecture](https://github.com/NSION/nscIotService---docker/blob/main/pictures/nscIotService-docker.png)
Above architecture diagram describes container interfaces to serve 4 dedicated data sources. 
