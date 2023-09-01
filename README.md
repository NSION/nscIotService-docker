# nscIotService-docker

This is a microservice based SW deployment specific repository for a NSC IoT client developed by NSION technologies Ltd.
- Instructions and scripts to setup container based nscIotService on edge computer node. Support for serveral RTSP based IP camera sources.

**Prerequisites for installation:**
- [x] At least 4Cores / 4GB RAM on edge computer
- [x] Docker and docker-compose are installed
- [x] Existing account for NSC services
- [x] NSC3 specific iot-key for backend authentication
- [x] Recommended OS: Ubuntu latest LTS, 64-bits operating system
- [x] Access to Device IP address via HTTP is enabled

## Installation instructions:
- [Docker installation for Raspberry Pi:](https://github.com/NSION/nscIotService-docker/blob/main/Installation-Raspberry-Pi.md)
- [Configuring NSC IoTClient docker version for Cradlepoint router:](https://github.com/NSION/nscIotService-docker/blob/main/How-to-Setup-Cradlepoint.md)
- [Configuring NSC IoTClient docker version for 64-bits ARM devices (linux/arm64):](https://github.com/NSION/nscIotService-docker/blob/main/How-to-Setup-arm64.md)
- [Configuring NSC IoTClient docker version for 64-bits AMD devices (linux/amd64):](https://github.com/NSION/nscIotService-docker/blob/main/How-to-Setup-amd64.md)
- [Installation of nscIotService (Old CLI management):](https://github.com/NSION/nscIotService-docker/blob/main/Installation-nscIotService.md)

## Alternative installation: 
### Windows installation (Native Windows app without docker):
- [Downloadable zip package for Windows NSCIoTClient (Application with installation instructions)](https://nscdevstorage.blob.core.windows.net/iotclientbundle/nsc-iot-client-bundle.zip)

## NSC Overview

NSC3™ is a  Realtime Resource Management for Intelligence Based Decision Making to Democratize your C2. Stream and store secured live video and data to other operators in the field and to  Control rooms. View video and data from drones, mobile phones, body cams, dashboard cams and surveillance cameras on your mobile phone in the field or on control room screens. Select the most relevant data source and always see real time data.   

![nsc3Web](https://www.nsiontec.com/wp-content/uploads/2020/08/WebApp_image-768x612.png)
![nsc3Overview](https://www.nsiontec.com/wp-content/uploads/2020/08/NSC3Overwiev-scaled-1-768x543.jpg)

### NSC IoT Client

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
