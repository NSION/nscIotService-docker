#!/bin/bash
# Move old files
mv docker-compose.yml docker-compose.old 2> /dev/null
# Remove old rtsp configuration files
rm ./nscIotConfig/* 2> /dev/null
# Attach iot-key file name
for keyfile in `ls ./iotkey`; do
export iotkey=$keyfile
if [ -z "$iotkey" ]
then 
	echo""
	echo "IOT key is missing from folder ./iotkey !!!"
	echo ""
exit 0
else 
	echo ""
	echo "IOT key $iotkey found "
	echo ""
fi  
done
echo "**********************************************************"
echo "NSC Iot client setup configurator:"
echo ""
echo "Select HW configuration:"
echo "1. Linux, MacOS or Win 64bit OS - amd64"
echo "2. Raspberry pi 4 with 32bit OS - armhf"
echo "3. Raspberry pi 4 with 64bit OS - arm64"
declare -i HWCONF
read HWCONF
if [ $HWCONF -eq 1 ]
then
    export hw="rc-amd64"
fi
if [ $HWCONF -eq 2 ]
then
    export hw="rc-armhf"
fi
if [ $HWCONF -eq 3 ]
then
    export hw="rc-arm64"
fi
if [ $HWCONF -gt 3 ]
then
    echo "Selected value $HWCONF is out of range 1-3!"
exit 0
fi
if [ $HWCONF -lt 1 ]
then
    echo "Selected value $$HWCONF is out of range 1-3!"
exit 0
fi
export uuid=$(uuidgen)
# create docker-compose file
( echo "cat <<EOF >docker-compose-mc-temp.yml";
cat docker-compose-mc-template.yml;
) >temp.yml
. temp.yml 2> /dev/null
cat docker-compose-mc-temp.yml > docker-compose.yml;
rm -f docker-compose-mc-temp.yml temp.yml 2> /dev/null
# create header file for iot conf
( echo "cat <<EOF >iotservice.temp";
cat iotservice.template;
) >temp.yml
. temp.yml 2> /dev/null
cat iotservice.temp > iotservice-header.temp;
rm -f iotservice.temp temp.yml 2> /dev/null
touch iotservice.temp
echo ""
echo "Number of video streams (^C to interrupt):"
declare -i STREAMS
read STREAMS
declare -i i=1
until test $i -gt $STREAMS
do
  echo "RTSP url address for video stream number $i:"
  read RTSP
  export RTSPurl=$RTSP
  # create video input configuration
  ( echo "cat <<EOF >iotservice-temp$i.yml";
  cat ipcamera.template;
  ) >temp
  . temp 2> /dev/null
  cat iotservice-temp$i.yml > iotservice-temppi.yml.yml;
  cat iotservice-temppi.yml.yml >> iotservice.temp;
  rm -f iotservice-temp$i.yml iotservice-temppi.yml.yml temp 2> /dev/null
  i=$(( $i + 1 ))
done
cat iotservice-header.temp iotservice.temp > ./nscIotConfig/iotservice.yaml
touch ./nscIotConfig/iotservice.properties
rm -f iotservice-header.temp iotservice.temp 2> /dev/null
echo "**********************************************************"
echo "New $hw based configuration is created for NSC Iot Client!"
echo "Number of video streams: $contid"
echo ""
echo "Start nscIotService by command:"
echo "sudo docker-compose up -d"
echo "**********************************************************"
