# Install nscIotService:

Note that this version of nscIoTClient is old and out of maintenance. We recommend to use latest versions instead.

Following instructions are providing instructions to build the docker image locally and push it to local docker registry.
Note: Following instructions are designed for older commandline (CLI) based configuration management. New versions are based on Web console configuration.

## Prerequisites for installation:
- [x] **Minimum HW requirements: 4 CPU cores, 4GB ram, 32GB free disk space.**
- [x] **Docker with docker-compose is installed:**

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
### Step 1: Clone git project 
```text 
cd ~
git clone https://github.com/NSION/nscIotService-docker.git
```
### Step 2:  Create nscIotService specific folder and grant execute rights for shell scripts
```text 
cd ~
mkdir ./nscIotService-docker/logs
mkdir ./nscIotService-docker/iotkey
mkdir ./nscIotService-docker/nscIotConfig
cd ./nscIotService-docker
chmod u+x *.sh
```
### Step 3:  Copy Nsc IoT key
- Copy the key file to the folder ./nscIotService-docker/iotkey/

### Step 4:  Setup your configuration
#### option1: NSC3 release 3.6 onwards (Multicamera support via single container)

```text 
cd ~/nscIotService-docker
./create-nsciotservice-mc.sh
```
#### option2: NSC3 release older releases (Multicamera support via multiple containers)

```text 
cd ~/nscIotService-docker
./create-nsciotservice.sh
```
Define hardware configuration. 
- Most typical hw configuration is amd64 by covering WindowsOS, MacOS and most of the Linux servers OS
- Raspberry pi 4 is using arm32 based HW
- New Raspberry pi 4 boards with 8GB RAM, Jetson boards and new MacOS laptops are using arm64 based HW
```text 
**********************************************************
NSC Iot client setup configurator:

Select HW configuration:
1. Linux, MacOS or Win 64bit OS - amd64
2. Raspberry pi 4 with 32bit OS - arm32
3. Raspberry pi 4 with 64bit OS - arm64
1
```
Define number of video streams, 5 is recommended max number. 
Below example set the value 2. 
Both streams are using the same demo rtsp stream source
```text 
Number of video streams (^C to interrupt):
2
```
```text 
RTSP url address for video stream number 1:
rtsp://wowzaec2demo.streamlock.net/vod/mp4:BigBuckBunny_115k.mov
```
```text 
RTSP url address for video stream number 2:
rtsp://wowzaec2demo.streamlock.net/vod/mp4:BigBuckBunny_115k.mov
```

### Step 5: Check installation 

Check that configuration files are created accordingly.

#### docker-compose.yml
##### NSC3 release 3.6 onwards (Multicamera support via single container)

```text 
more docker-compose.yml
```
- Check that file looks as proper docker-compose yaml file
- Only 1 Container is created

##### NSC3 release older releases (Multicamera support via multiple containers)

```text 
more docker-compose.yml
```
- Check that file looks as proper docker-compose yaml file
- 1 Container per stream is created. Check that number of containers are matching with your setup

#### Video inbound configuration
##### NSC3 release 3.6 onwards (Multicamera support via single container)
```text 
more ./nscIotConfig/iotservice.yaml
```
as example output
```text 
---
configuration:
  deviceID: "79EA70C0-AD8C-4CD1-96DF-B0E443ACC3BE"
  location:
    latitude: 0.0
    longitude: 0.0
sources:
- identifier: "rtsp://wowzaec2demo.streamlock.net/vod/mp4:BigBuckBunny_115k.mov"
  type: "NETWORKCAMERA"
  autostart: true
- identifier: "rtsp://rtsp.stream/pattern"
  type: "NETWORKCAMERA"
  autostart: true
```

##### NSC3 release older releases (Multicamera support via multiple containers)
```text 
ls ./nscIotConfig
```
Check that 
- each of the streams do have own dedicated configuration file.
- rtsp URL is created accordingly 
e.g 

```text 
more ./nscIotConfig/iotservice.properties1
```
as example output
```text 
IOT_SERVICE_LIVE_AUTOSTART_NAME_KEY=true
IOT_SERVICE_LIVE_NETWORK_INPUTSOURCE_NAME_KEY=rtsp://wowzaec2demo.streamlock.net/vod/mp4:BigBuckBunny_115k.mov
```
#### Check video sources:

Note: Currently supported only for installation option 2 (Multicamera support via multiple containers)

Following command prints a list of rtsp url addresses configured per camera:
```text 
./nscIotService-inbound-streams.sh
```
Example of expected output:
```text 
*************************************************************
List of rtsp url addresses configured per camera: 

camera1: rtsp://wowzaec2demo.streamlock.net/vod/mp4:BigBuckBunny_115k.mov
camera2: rtsp://wowzaec2demo.streamlock.net/vod/mp4:BigBuckBunny_115k.mov
```

## Start NSCiotServices:

```text
cd ~/nscIotService-docker
sudo docker-compose up -d
```
Note that at the first start will pull docker image from dockerhub to local docker registry.

## Ensure that stream is visible on NSC3 WebUI:
- Login to your NSC3 organisation
- Select default task
- Recently created video devices shall be visible like below example
![WebUI](https://github.com/NSION/nscIotService-docker/blob/main/pictures/NSC3Web-sample.png)

### Troubleshooting:

Note: Currently supported only for installation option 2 (Multicamera support via multiple containers)

#### Check broadcasting status
```text
./nscIotService-broadcasting-status.sh 
```
As an example printout, Broadcasting for camera1 is working and camera2 service is down.

```text
*************************************************************
NSC3 Broadcasting status per camera sourcs:

camera1: {"liveStreaming":"active","connectionStatus":"connected"} 
camera2: No broadcasting status 
```
#### Potential solutions
Check container status:
```text
sudo docker-compose ps
```
As an example printout, container1 is up and container2 is down.

```text
     Name            Command       State           Ports         
-----------------------------------------------------------------
nsciotservice1   catalina.sh run   Up      0.0.0.0:8091->8080/tcp
nsciotservice2   catalina.sh run   Down    0.0.0.0:8092->8080/tcp
```
Restart docker:

```text
sudo docker-compose restart
sudo docker-compose ps
```
As an example printout, container1 is up and container2 has restarted.

```text
     Name            Command       State           Ports         
-----------------------------------------------------------------
nsciotservice1   catalina.sh run   Up      0.0.0.0:8091->8080/tcp
nsciotservice2   catalina.sh run   Up      0.0.0.0:8092->8080/tcp
```

## Maintenance of NSCIotService:

Note: Currently supported only for installation option 2 (Multicamera support via multiple containers)

### Basic operations:
#### Shutdown nscIotService:
```text
cd ~/nscIotService-docker
sudo docker-compose down
```
#### Upgrade nscIotService:
```text
cd ~/nscIotService-docker
sudo docker-compose down
sudo docker-compose pull
sudo docker-compose up -d
```
#### Change rtsp video sources:
It is recommened to do changes for existing setup by modifying directly corresponding configuration file insted of running installation process once again.
Change one of the video source configuration files on folder ./nscIotConfig
```text
cd ~/nscIotService-docker
sudo docker-compose restart
```
### Cleanup log files:
NSC IoT client specific log files are located to the several subfolders of ~nscIotService/logs
#### Manual cleanup:
Syntax: ```text find <root folder> -mtime +<older than x days> -type f -delete```

As an example to delete log files older than 14 days
```text
find ~/nscIotService-docker/logs -mtime +14 -type f -delete
```
#### Automated cleanup:
Following example is based on cronjob

Cronjob syntax:

```text
* * * * * command to be executed
- - - - -
| | | | |
| | | | ----- Day of week (0 - 7) (Sunday=0 or 7)
| | | ------- Month (1 - 12)
| | --------- Day of month (1 - 31)
| ----------- Hour (0 - 23)
------------- Minute (0 - 59)
```
As an example set cronjob to delete older than 14 days log files daily based at 7:00 AM.
```text
crontab -e
```
```
0 7 * * * find ~/nscIotService-docker/logs -mtime +14 -type f -delete
```
Save changes on editor ```<esc>``` -button  and ```:wq!```

#### Update git repository:
nscIotService-docker git repository is under continous development. Therefore it is reasonable to update local configuration at time to time.
This update won't overwrite your existing runtime configuration. This action won't upgrade nscIotServices, but brings new tools to manage NSC IOT services.

```text
cd ~/nscIotService-docker
git pull
chmod u+x *.sh
```
## Configure nscIotService:

### Configurable runtime elements:

Root dir: ```~/nscIotService-docker```

| **Object** | **Configuration file** | **Example** | 
| :--- |     :---      |   :---  |   
| IP address: | docker-compose.yml | ipv4_address: 172.21.0.2 |
| Port: | docker-compose.yml | - 8091:8080 #8091 as exposed port| 
| IOT key: | docker-compose.yml| ./iotkey/test.nsc.iot:/opt/tomcat/webapps/test.nsc.iot| 
| RTSP url: | ./nscIotConfig/iotservice.properties<nr> | IOT_SERVICE_LIVE_NETWORK_INPUTSOURCE_NAME_KEY=rtsp://xxx| 
| Broadcast parameters: | ./nscIotConfig/iotservice.properties<nr> | see below chapter ... | 

For all of the above mentioned configurable objects, changes will be taken into use by restarting services

```sudo docker-compose restart``` 

### Optimize broadcasting:

Configuration file location: ```~/nscIotService/nscIotConfig/iotservice.properties(number)```

Note that changes will be affected when remove the ```#``` at the beginning of the line.

``` text
# --- Autostart for selected camera source
#IOT_SERVICE_LIVE_AUTOSTART_NAME_KEY=true
# --- rtsp camera source
#IOT_SERVICE_LIVE_NETWORK_INPUTSOURCE_NAME_KEY=rtsp://<user>:<passkey>@<IP address>
# --- Integrated device camera support as example
#IOT_SERVICE_LIVE_CAMERA_INPUTSOURCE_NAME_KEY=Integrated Camera
# --- Frame rate fps15 as example
#IOT_SERVICE_LIVE_FRAMERATE_KEY=15
# --- FFMPEG quality parameters https://ffmpeg.org/ffmpeg.html
# IOT_SERVICE_LIVE_FFMPEG_QUALITY_KEY=30
# --- Picture width size 320pix as example
#IOT_SERVICE_LIVE_FRAME_WIDTH_KEY=320 
# --- Picture height size 240pix as example
#IOT_SERVICE_LIVE_FRAME_HEIGHT_KEY=240
```

  
## Remove NSCIoTClient from linux
  
Shutdown and removing IoTClient containers:

```
sudo docker-compose down
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
