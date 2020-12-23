# Install nscIotService
Following instructions are providing instructions to build the docker image locally and push it to local docker registry.
## Prerequisites for installation
- Docker with docker-compose installed
Ohjeita
- Download the corresponding Nsc IoT key from the NSC3 organisation as admin-user or key-user.
Ohjeet tänne.
- url addresses for each of the RTSP camera sources are available

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

### Setup your configuration

```text 
cd ~
./create-nsciotservice.sh
```
Define number of video streams, 5 is recommended max number. 
As an example value is 2. Both streams are using the same demo rtsp stream source

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
