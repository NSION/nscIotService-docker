# Installation instructions for amd64 based devices:
Following instructions are providing step by step guidance to install and setup nscIOTservice for linux/amd64 based devices.
Verified with Ubuntu based OS.

NOTE: IP camera and NSC backend configuration via local Web Console is only available.

## Prerequisites for installation:
- [x] **linux/amd64 Operating system is installed to device/server**
- [x] **Docker (with Docker compose) is installed to device/server**

Below list is collecting detailed guidelines for per OS to install Docker and docker-compose
+ [Windows](https://docs.docker.com/docker-for-windows/install-windows-home/)
+ [MAC](https://docs.docker.com/docker-for-mac/install/)
+ [Ubuntu](https://docs.docker.com/engine/install/ubuntu/)
+ [docker-compose](https://docs.docker.com/compose/install/)
  
- [x] **GIT is installed to device/server**
- [x] **Access to Device IP address via HTTP is enabled**
- [x] **Account for the NSC3 organization, at least keyuser level user rights for organisation is required to allow downloading iotkey file**
- [x] **NSC IOT key file downloaded to target organization:**

Download NSC access key for the NSC3 organisation as admin-user or key-user.

+ Login to NSC3 Web UI admin panel as admin or key user
+ Select the targeted organization and click "arrow down" icon
<img src="https://github.com/NSION/nscIotService-docker/blob/main/pictures/how-to-iotkey.png" width="420" height="324">

- [x] **RTSP url addresses for each of the camera sources:**

The Real Time Streaming Protocol (RTSP) is a network control protocol designed for use in entertainment and communications systems to control streaming media servers. [RTSP Wiki](https://en.wikipedia.org/wiki/Real_Time_Streaming_Protocol). 
+ Ensure that camera sources are accessable via Cradlepoint router.

## Install NSC3 container 

#### 1. Login to arm device via ssh
#### 2. Clone the git project

```text 
cd ~
git clone https://github.com/NSION/nscIotService-docker.git
```
#### 3. Start-up NSC IOTClient

```text 
cd ~/nscIotService-docker
sudo docker-compose -f docker-compose-amd64.yml up -d
```

## Configure NSC access via local nscIoTClient manager

Following steps requires access to Cradlepoint local network. 


### Open nscIoTClient local manager

- Open Browser to address: arm-device_IP_address:8090 as example http://192.168.0.100:8090

<img src="https://github.com/NSION/nscIotService-docker/blob/main/pictures/nscIotClient-key.png" width="600" height="320">

#### Connect to NSC3 server
  
- Upload the NSC3 iotkey file. 
- When connection status gets green color -> nscIotClient is connected to NSC3 server.
  
#### Connect IP cams to nscIotClient
  
- Select "Camera sources" -> "IP camera source" -> "Next"
  
<img src="https://github.com/NSION/nscIotService-docker/blob/main/pictures/nscIotClientDevice.png" width="600" height="320">
  
- Define name, rtsp address and required credentials for camera. As example rtsp://wowzaec2demo.streamlock.net/vod/mp4:BigBuckBunny_115k.mp4
  
<img src="https://github.com/NSION/nscIotService-docker/blob/main/pictures/nscIotClient-rtsp.png" width="500" height="320">

#### Start broadcasting to NSC3 server

- Activate broadcasting to NSC3 server (Local view)
  
<img src="https://github.com/NSION/nscIotService-docker/blob/main/pictures/nscIotClient-localview.png" width="600" height="320">
  
- Verify results on NSC3 Web UI (Remove view)
  
<img src="https://github.com/NSION/nscIotService-docker/blob/main/pictures/nscIotClient-backend.png" width="600" height="320">
  
## Basic operations:
### Shutdown nscIotService:
```text
cd ~/nscIotService-docker
sudo docker-compose -f docker-compose-amd64.yml down
```

### Start up nscIotService:
```text
cd ~/nscIotService-docker
sudo docker-compose -f docker-compose-amd64.yml up -d
```

### Upgrade nscIotService:
```text
cd ~/nscIotService-docker
sudo docker-compose -f docker-compose-amd64.yml down
sudo docker-compose -f docker-compose-amd64.yml pull
sudo docker-compose -f docker-compose-amd64.yml up -d
```

## Remove NSCIoTClient from linux
  
Shutdown and removing IoTClient containers:

```
sudo docker-compose -f docker-compose-amd64.yml down
```
  
Removing unused Docker Images:  

```
sudo docker image prune 
```
  
Removing all unused network:
  
```
sudo docker network prune
```
  
Removing all unused volumes:
  
```
sudo docker volume prune
```
  
## [nscIotService API spec:](https://github.com/NSION/nscIotService-emergency-button#api-specifications)
