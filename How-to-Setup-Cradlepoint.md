# Installation instructions for [Cradlepoint router]( https://cradlepoint.com) to install and setup nscIoTClient as a microservice:
Following instructions are providing step by step guidance to install and setup nscIOTservice for Cradlepoint router.
## Prerequisites for installation:
- [x] **Cradlepoint router model [R1900](https://cradlepoint.com/product/endpoints/r1900-series/)**
- [x] **Router is connected to network**
- [x] **Account for Cradlepoint [NetCloud](https://www.cradlepointecm.com/ecm.html#devices/routers)**
- [x] **An existing account for the NSC3 organization**

Below list is collecting detailed guidelines for several OS to install Docker

+ [Windows](https://docs.docker.com/docker-for-windows/install-windows-home/)
+ [MAC](https://docs.docker.com/docker-for-mac/install/)
+ [Ubuntu](https://docs.docker.com/engine/install/ubuntu/)
+ [docker-compose](https://docs.docker.com/compose/install/)
+ [Raspberry Pi4](https://github.com/NSION/nscIotService-docker/blob/main/Installation-Raspberry-Pi.md)

- [x] **NSC IOT key:**

Download the corresponding Nsc IoT key from the NSC3 organisation as admin-user or key-user.

+ Login to NSC3 Web UI admin panel as admin or key user
+ Select the targeted organization and click "arrow down" icon
<img src="https://github.com/NSION/nscIotService-docker/blob/main/pictures/how-to-iotkey.png" width="324" height="324">

- [x] **RTSP url addresses for each of the camera sources:**

The Real Time Streaming Protocol (RTSP) is a network control protocol designed for use in entertainment and communications systems to control streaming media servers. [RTSP Wiki](https://en.wikipedia.org/wiki/Real_Time_Streaming_Protocol). 
+ Ensure that DHCP is activated on camera.


## Setup environment:
- Login to server. 
- Open terminal to home folder
- Install UUIDGEN tool
```text 
sudo apt-get install uuid-runtime
```
### Step 1: Clone git
