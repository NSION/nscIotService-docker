# Raspberry Pi - Docker:
Docker is a tool for creating, deploying, and running applications in containers. 
The software is popular among developers as it speeds up the development process and does not use a lot of resources.
Docker containers are lightweight, especially compared to virtual machines. This feature is especially valuable if you are a Raspberry Pi user.
## Prerequisites:
- Raspberry Pi 4 / 4GB RAM
- Raspberry Pi with a running Rasbian OS (Debian based OS)
## Instructions to setup Raspberry SD card
- SSH connection enabled 
- Instruction to enable remote ssh connection
- While installation phase you need to have connection to services located on internet

# Installation:
## Install Docker on Raspberry Pi:
To install Docker on your Raspberry Pi, you need to go through the following steps:
- Update and upgrade your system.
- Download the installation script and install the package.
- Allow a non-root user to execute Docker commands.
- Verify installation by checking the Docker version.
- Test the set up by running a “hello-world” container.
- Install Docker additional features

## Step 1: Update and Upgrade
Start by updating and upgrading the system. This ensures you install the latest version of the software.

Open a terminal window and run the command:
```text 
sudo apt-get update && sudo apt-get upgrade
```
```text 
ln -s /mnt/c/Users/<user>/hackstack $HOME
```

## Step 2: Download the Convenience Script and Install Docker on Raspberry Pi

Move on to downloading the installation script with:
```text 
curl -fsSL https://get.docker.com -o get-docker.sh
```

Execute the script using the command:
```text 
sudo curl -fsSL get.docker.com -o get-docker.sh && sh get-docker.sh
```

## Step 3: Add a Non-Root User to the Docker Group

By default, only users who have administrative privileges (root users) can run containers. If you are not logged in as the root, one option is to use the sudo prefix. However, you could also add your non-root user to the Docker group which will allow it to execute docker commands.

The syntax for adding users to the Docker group is:
```text 
sudo usermod -aG docker $USER´
```
To add the Pi user (the default user in Raspbian), use the command:
```text 
sudo usermod -aG docker pi
```

There is no specific output if the process is successful. 
For the changes to take place, you need to restart Pi
```text 
reboot
```

## Step 4: Check Docker Version and Info
Check the version of Docker on your Raspberry Pi by typing:
```text 
docker version
```
The output will display the Docker version along with some additional information.
For system-wide information (including the kernel version, number of containers and images, and more extended description) run:
```text 
docker info
```
## Step 5: Run Hello World Container
The best way to test whether Docker has been set up correctly is to run the Hello World container.
To do so, type in the following command:
```text 
docker run hello-world
```
## Step 6: Install docker additional features
Docker Compose:
```text 
sudo apt-get install docker-compose
```

## Your Raspberry Pi environment is ready for NSC Iot Client installation
