# Install nscIotService
Following instructions are providing instructions to build the docker image locally and push it to local docker registry.
## Prerequisites for installation:
#### - Docker with docker-compose is installed. Below list of instructions for several OS
+ [Windows](https://docs.docker.com/docker-for-windows/install-windows-home/)
+ [MAC](https://docs.docker.com/docker-for-mac/install/)
+ [Ubuntu](https://docs.docker.com/engine/install/ubuntu/)
+ [docker-compose](https://docs.docker.com/compose/install/)
+ [Raspberry Pi4](https://github.com/NSION/nscIotService-docker/blob/main/Installation-Raspberry-Pi.md)

#### - Download the corresponding Nsc IoT key from the NSC3 organisation as admin-user or key-user.
++ Ohjeet tänne.

#### - url addresses for each of the RTSP camera sources are available

## Setup enviroment:
- Login to server. 
- Open terminal to home folder

### Step 1: Clone git project 
```text 
cd ~
git clone https://github.com/NSION/nscIotService-docker.git
```
### Step 2:  Create nscIotService specific folder
```text 
cd ~
mkdir ./nscIotService-docker/logs
mkdir ./nscIotService-docker/iotkey
```
### Step 3:  Copy Nsc IoT key
- Copy the key file to the folder ./nscIotService-docker/iotkey/

### Step 4:  Setup your configuration

```text 
cd ~/nscIotService-docker
./create-nsciotservice.sh
```
Define number of video streams, 5 is recommended max number. 
Below as an example the stream source value is set 2. 
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

### Step 4:  Verify installation

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
## Start NSCiotServices:

```text
cd ~/nscIotService-docker
sudo docker-compose up -d
```
Note that at the first start will pull docker image from dockerhub to local docker registry.

## Check the video stream from NSC3 WebUI:
- Login to your NSC3 organisation
- Select default task
- Recently created video devices shall be visible like below example


## Maintenence of NSCIotService:
#### Shutdown nscIotService
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



