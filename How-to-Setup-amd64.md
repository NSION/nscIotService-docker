# Installation instructions for amd64 based devices:
Following instructions are providing step by step guidance to install and setup nscIOTservice for linux/amd64 based devices.
Verified with Ubuntu based OS.

NOTE: IP camera and NSC backend configuration via local Web Console is only available.

## Prerequisites for installation:
- [x] **linux/amd64 based operating system is installed to device/server**
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
+ Ensure that camera sources are accessable. You could validate rtsp stream by e.g VLC Player.

## Install NSC3 container 

#### 1. Login to amd device via ssh
#### 2. Add additional tools and clone the git project
```text
sudo apt install curl jq git
```
```text 
cd ~
git clone https://github.com/NSION/nscIotService-docker.git
```
#### 3. Start-up NSC IOTClient

```text 
cd ~/nscIotService-docker
chmod u+x *.sh
mkdir iotconfig
touch ./iotconfig/nscIoTConf.env
ln -s docker-compose-amd64.yml docker-compose.yml
sudo docker-compose up -d
```

## Configure NSC access via local nscIoTClient manager or command line tool (CLI)

Following steps requires access to local network. 


### Open nscIoTClient local manager (Web UI)

- Open Browser to address: device_IP_address:8090 as example http://192.168.0.100:8090 or http://localhost:8090

<img src="https://github.com/NSION/nscIotService-docker/blob/main/pictures/nscIotClient-key.png" width="600" height="320">

#### Connect to NSC3 server (Web UI)
  
- Upload the NSC3 iotkey file. 
- When connection status gets green color -> nscIotClient is connected to NSC3 server.
  
#### Connect IP cams to nscIotClient (Web UI)
  
- Select "Camera sources" -> "IP camera source" -> "Next"
  
<img src="https://github.com/NSION/nscIotService-docker/blob/main/pictures/nscIotClientDevice.png" width="600" height="320">
  
- Define name, rtsp address and required credentials for camera. As example rtsp://wowzaec2demo.streamlock.net/vod/mp4:BigBuckBunny_115k.mp4
  
<img src="https://github.com/NSION/nscIotService-docker/blob/main/pictures/nscIotClient-rtsp.png" width="500" height="320">

#### Start broadcasting to NSC3 server (Web UI)

- Activate broadcasting to NSC3 server (Local view)
  
<img src="https://github.com/NSION/nscIotService-docker/blob/main/pictures/nscIotClient-localview.png" width="600" height="320">
  
- Verify results on NSC3 Web UI (Remove view)
  
<img src="https://github.com/NSION/nscIotService-docker/blob/main/pictures/nscIotClient-backend.png" width="600" height="320">

### Managed nscIoTClient with CLI tool (nscIoTClient-CLI.sh)

```text 
Usage: nscIoTClient-CLI.sh [OPTIONS] COMMAND [ARGS]

Options:
  -h, --help        Show this help message and exit

Commands:
  status            nscIoTClient status
  list              List of streaming devices
  add               Add new streaming sources
    Arguments:      e.g 'add -name testcam -url rtsp://test.com:554 -u test -p mypass'
    -name           Name of stream source 
    -url            URL address for streaming port 
    -u              Camera user authentication: user. If no user credentials then -u '' 
    -p              Camera user authentication: password. If no passwd credentials then -p '' 
  remove            Remove streaming source
    Arguments:      e.g 'remove -sourceID 4911a9a5-f6af-4ee0-aa50-75e61f9d67c9'
    -sourceID       ID of stream source, list of streaming sources by 'list' command
  iotkey            Add or update new iot-key
    Arguments:      e.g 'iotkey -location /home/ubuntu/test.nsc.iot'
    -location       Location and file name of iotkey
  control           Start/Stop video stream
    Arguments:      e.g 'control -sourceID 4911a9a5-f6af-4ee0-aa50-75e61f9d67c9 start'
    -sourceID       ID of stream source, list of streaming sources by 'list' command
    start/stop      options: start or stop
  optimize          Optimize video quality. Options value or default. Argument 'default' means no-changes
    Arguments:      e.g (only fps) 'optimize -fps 10 -framewidth default -frameheight default'
    -fps            Frames per second, 'default' as camera source, usually value '25'
    -framewidth     FRAME_WIDTH, 'default' as camera source, HD(p720) e.g '1280'
    -frameheight    FRAME_HEIGHT, 'default' as camera source, HD(p720) e.g '720'
```
#### Configurable runtime settings of nscIoTClient CLI tool (nscIoTClient-CLI.sh)

Runtime configurability is defined in the shell script nscIoTClient-CLI.sh

```text
cd ~/nscIotService-docker
nano nscIoTClient-CLI.sh
```
```text
...
# Runtime parameters
IOTHOSTNAME="localhost" # Default is localhost, if something else modify your IoTClient domain address here
IOTPORT="8090" # Default is 8090, if something else modify your IoTClient port here
TIMESTAMP=$(date +%Y%m%d%H%M)
SUDO=false  # If docker requires sudo grants then set this env. variable to true
...
```
#### Getting started with (nscIoTClient-CLI.sh)

##### Initialization:

Pair the nscIotService with NSC3 backend by iotkey

```text
cd ~/nscIotService-docker
./nscIoTClient-CLI.sh iotkey -location <location and filename of iotkeyfile>
```

Expected result:

```text
The iot-key found from '<path>'
[+] Running 1/1
 ⠿ Container nsciotservice-docker-nsciotservice-1  Started                                                                                                               1.0s
Connection status with new iotkey = SUCCESS
```

##### Check status:

Check connectivity status to NSC3 backend

```text
cd ~/nscIotService-docker
./nscIoTClient-CLI.sh status
```

Expected result:

```text
Connection status to NSC3 server = connected
Streaming status to NSC3 server = inactive
```

##### add networkCams:

Add new IP cam and start streaming

```text
cd ~/nscIotService-docker
./nscIoTClient-CLI.sh add -name mycam -url http://123.123.123.123/mjpg/video.mjpg -u '' -p ''
```

Expected result:

```text
Added network source from http://123.123.123.123/mjpg/video.mjpg with id fa0f7d57-f511-4424-a7f3-0aa3876c52d0
Starting new camera...
Source found and attempt stream start.
```

Validate broadcasting status:

```text
./nscIoTClient-CLI.sh list
```

Expected result:

```text
name,streamSourceId,type,address,autostart,broadcastStatus
"mycam","fa0f7d57-f511-4424-a7f3-0aa3876c52d0","NETWORKCAMERA","http://123.123.123.123/mjpg/video.mjpg",true,"BROADCASTING"
```

##### control networkCams:

Stop streaming:

```text
cd ~/nscIotService-docker
./nscIoTClient-CLI.sh control -sourceID fa0f7d57-f511-4424-a7f3-0aa3876c52d0 stop
```

Expected result:

```text
Executing control command with arguments: '-sourceID fa0f7d57-f511-4424-a7f3-0aa3876c52d0 stop'
control syntax ok: fa0f7d57-f511-4424-a7f3-0aa3876c52d0 stop
Issued a stop command for stream fa0f7d57-f511-4424-a7f3-0aa3876c52d0
```

Start streaming:

```text
cd ~/nscIotService-docker
./nscIoTClient-CLI.sh control -sourceID fa0f7d57-f511-4424-a7f3-0aa3876c52d0 start
```

Expected result:

```text
Executing control command with arguments: '-sourceID fa0f7d57-f511-4424-a7f3-0aa3876c52d0 start'
control syntax ok: fa0f7d57-f511-4424-a7f3-0aa3876c52d0 start
Source found and attempt stream start.
```

Validate broadcasting status:

```text
./nscIoTClient-CLI.sh list
```

Expected result:

```text
name,streamSourceId,type,address,autostart,broadcastStatus
"mycam","fa0f7d57-f511-4424-a7f3-0aa3876c52d0","NETWORKCAMERA","http://123.123.123.123/mjpg/video.mjpg",true,"BROADCASTING"
```


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
