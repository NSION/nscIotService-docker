# Install nscIotService
Following instructions are providing instructions to build the docker image locally and push it to local docker registry.

## Setup enviroment:
- Login to Rasp Pi as pi user. 
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
- Download the corresponding Nsc IoT key from the NSC3 organisation as admin-user or key-user.
- Copy the key file to the folder ./nscIotService-docker/iotkey

