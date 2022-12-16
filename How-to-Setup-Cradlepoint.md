# Installation instructions for [Cradlepoint router]( https://cradlepoint.com) to install and setup nscIoTClient as a microservice:
Following instructions are providing step by step guidance to install and setup nscIOTservice for Cradlepoint router.

<img src="https://github.com/NSION/nscIotService-docker/blob/main/pictures/Cradlepoint-NSC3.png" width="680" height="324">

## Prerequisites for installation:
- [x] **Cradlepoint router model [R1900](https://cradlepoint.com/product/endpoints/r1900-series/) with an Advanced License**
- [x] **Router is connected to network**
- [x] **NetCloud OS (NCOS) Version 7.2.20 or newer**
- [x] **Account for Cradlepoint [NetCloud](https://www.cradlepointecm.com/ecm.html#devices/routers)**
- [x] **An existing account for the NSC3 organization**
- [x] **NSC IOT key:**

Download NSC access key for the NSC3 organisation as admin-user or key-user.

+ Login to NSC3 Web UI admin panel as admin or key user
+ Select the targeted organization and click "arrow down" icon
<img src="https://github.com/NSION/nscIotService-docker/blob/main/pictures/how-to-iotkey.png" width="420" height="324">

- [x] **RTSP url addresses for each of the camera sources:**

The Real Time Streaming Protocol (RTSP) is a network control protocol designed for use in entertainment and communications systems to control streaming media servers. [RTSP Wiki](https://en.wikipedia.org/wiki/Real_Time_Streaming_Protocol). 
+ Ensure that camera sources are accessable via Cradlepoint router.

## Install NSC3 container to Cradlepoint router

#### 1. Login to [NetCloud](https://www.cradlepointecm.com/ecm.html#devices/routers)

#### 2. Devices: Select your Router device and click EDIT
<img src="https://github.com/NSION/nscIotService-docker/blob/main/pictures/Cradlepoint1.png" width="520" height="324">

#### 3. Edit Configuration: SYSTEM→CONTAINER→PROJECT. 

- Select "Add" 

<img src="https://github.com/NSION/nscIotService-docker/blob/main/pictures/Cradlepoint2.png" width="520" height="324">

#### 4. Project configuration: Config

- Select "nsc3" for a Container project name and click "Compose" tab

<img src="https://github.com/NSION/nscIotService-docker/blob/main/pictures/Cradlepoint3.png" width="420" height="420">

#### 5. Project configuration: Compose

<img src="https://github.com/NSION/nscIotService-docker/blob/main/pictures/Cradlepoint5.png" width="420" height="420">

- Copy and paste following configuration to "Compose" editor and click "Compose builder" tab

```
version: '2.4'
services:
  nsciotservice:
    network_mode: bridge
    image: 'nsiontech/nsciotservice:quarkus-arm64'
    command: ''
    entrypoint: /deployments/run-java.sh
    working_dir: ''
    user: ''
    logging:
      driver: json-file
      options: {}
    ports:
      - '8090:8090'
    volumes:
      - 'nsciot-volume:/deployments/statedb'
volumes:
  nsciot-volume:
    driver: local
```

#### 6. Project configuration: Compose builder

- Select "Network" / "Primary LAN" and click "Save"

<img src="https://github.com/NSION/nscIotService-docker/blob/main/pictures/Cradlepoint7.png" width="420" height="420">

#### 7. Project configuration: Compose 

- Expose container port "8090" to your gateway IP address as below example "192.168.0.1:8090:8090". Ensure your GW IP address, Reference -> Network parameteres on Compose configuration 

<img src="https://github.com/NSION/nscIotService-docker/blob/main/pictures/Cradlepoint8.png" width="420" height="420">

#### 8. Commit changes 

- Select "Network" / "Primary LAN" and click "Save"

<img src="https://github.com/NSION/nscIotService-docker/blob/main/pictures/Cradlepoint9.png" width="420" height="420">

#### 9. Check status of container deployment

- Select 

- Container pulling process and initialization will take roughly 5-10 mins. 

<img src="https://github.com/NSION/nscIotService-docker/blob/main/pictures/Cradlepoint10.png" width="420" height="420">

## Configure NSC3 via local nscIoTClient manager

### 
