# Installation instructions for [Cradlepoint router]( https://cradlepoint.com) to install and setup nscIoTClient as a microservice:
Following instructions are providing step by step guidance to install and setup nscIOTservice for Cradlepoint router.

<img src="https://github.com/NSION/nscIotService-docker/blob/main/pictures/Cradlepoint-NSC3.png" width="680" height="324">

## Prerequisites for installation:
- [x] **Cradlepoint router model [R1900](https://cradlepoint.com/product/endpoints/r1900-series/) with an Advanced License**
- [x] **Router is connected to network**
- [x] **NetCloud OS (NCOS) Version 7.2.20 or newer**
- [x] **Account for Cradlepoint [NetCloud](https://www.cradlepointecm.com/ecm.html#devices/routers) **
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
- Login to [NetCloud](https://www.cradlepointecm.com/ecm.html#devices/routers)
- Devices: Select your Router device and click EDIT
<img src="https://github.com/NSION/nscIotService-docker/blob/main/pictures/Cradlepoint1.png" width="420" height="324">
- Edit Configuration: Configure your container SYSTEM→CONTAINER→PROJECT. Select "Add" 
<img src="https://github.com/NSION/nscIotService-docker/blob/main/pictures/Cradlepoint2.png" width="420" height="324">
- Edit Configuration: Configure your container SYSTEM→CONTAINER→PROJECT. Select "nsc3" for a Container project name 
<img src="https://github.com/NSION/nscIotService-docker/blob/main/pictures/Cradlepoint3.png" width="420" height="324">

### Step 1: Clone git
