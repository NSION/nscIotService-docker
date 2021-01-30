# Install nscIotService
Following instructions are providing instructions to build the docker image locally and push it to local docker registry.
## Prerequisites for installation:
#### Docker with docker-compose is installed. Below list is collecting detailed instruction guides for several OS to install Docker
+ [Windows](https://docs.docker.com/docker-for-windows/install-windows-home/)
+ [MAC](https://docs.docker.com/docker-for-mac/install/)
+ [Ubuntu](https://docs.docker.com/engine/install/ubuntu/)
+ [docker-compose](https://docs.docker.com/compose/install/)
+ [Raspberry Pi4](https://github.com/NSION/nscIotService-docker/blob/main/Installation-Raspberry-Pi.md)

#### Download the corresponding Nsc IoT key from the NSC3 organisation as admin-user or key-user.
+ Login to NSC3 Web UI admin panel as admin or key user
+ Select the targeted organization and click "arrow down" icon
<img src="https://github.com/NSION/nscIotService-docker/blob/main/pictures/how-to-iotkey.png" width="324" height="324">

#### url addresses for each of the RTSP camera sources are available

## Setup enviroment:
- Login to server. 
- Open terminal to home folder

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
chmod u+x *.sh
```
### Step 3:  Copy Nsc IoT key
- Copy the key file to the folder ./nscIotService-docker/iotkey/

### Step 4:  Setup your configuration

```text 
cd ~/nscIotService-docker
./create-nsciotservice.sh
```
Define hardware configuration. 
- Most typical hw configuration is amd64 by covering WindowsOS, MacOS and most of the Linux servers OS
- Raspberry pi 4 or Jetson boards are using arm32 based HW
- New Raspberry pi 4 boards with 8GB RAM or new MacOS laptops are using arm64 based HW
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

### Step 5:  Verify installation

Check that configuration files are created accordingly.

#### docker-compose.yml

```text 
more docker-compose.yml
```
- Check that file looks as proper docker-compose yaml file
- 1 Container per stream is created. Check that number of containers are matching with your setup

#### Video inbound configuration

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
docker-compose ps
```
As an example printout, container1 is up and container2 is down.

```text
     Name            Command       State           Ports         
-----------------------------------------------------------------
nsciotservice1   catalina.sh run   Up      0.0.0.0:8091->8080/tcp
```
Restart docker:

```text
docker-compose restart
docker-compose ps
```
As an example printout, container1 is up and container2 has restarted.

```text
     Name            Command       State           Ports         
-----------------------------------------------------------------
nsciotservice1   catalina.sh run   Up      0.0.0.0:8091->8080/tcp
nsciotservice2   catalina.sh run   Up      0.0.0.0:8092->8080/tcp
```

## Maintenance of NSCIotService:
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
