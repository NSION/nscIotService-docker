# Install nscIotService
Following instructions are providing instructions to build the docker image locally and push it to local docker registry
Prepare configuration:
Login to Rasp Pi as pi user. Open terminal to home folder
## Step 1:  Create nscIotService specific folder
```text 
cd ~
mkdir nscIotService
mkdir ./nscIotService/logs
mkdir ./nscIotService/nscwars
mkdir ./nscIotService/nscIotConfig
mkdir ./nscIotService/iotkey
```
## Step 2:  Copy Nsc IoT key
- Download the corresponding Nsc IoT key from the NSC3 organisation as admin user
- Copy the key file to the folder ./nscIotService/iotkey

## Step 3:  Copy nscIotService.war package to the Rasp Pi
Copy nscIotService.war file the folder ./nscIotService/nscwars

## Step 4:  Copy docker configuration files to the Rasp Pi
- Copy Dockerfile to the folder ./nscIotService
- Copy docker-compose.yml file to the folder ./nscIotService
