#!/bin/bash
# Move old files
mv docker-compose.yml docker-compose.old
# Remove old rtsp configuration files
rm ./nscIotConfig/*
# Attach iot-key file name
for keyfile in `ls ./iotkey`; do
export iotkey=$keyfile
done
echo "**********************************************************"
echo "NSC Iot client setup configurator:"
echo ""
echo "Select HW configuration:"
echo "1. Linux, MacOS or Win 64bit OS - amd64"
echo "2. Raspberry pi 4 with 32bit OS - arm32"
echo "3. Raspberry pi 4 with 64bit OS - arm64"
declare -i HWCONF
read HWCONF
if [ $HWCONF -eq 1 ]
then
    export hw="amd64"
fi
if [ $HWCONF -eq 2 ]
then
    export hw="arm"
fi
if [ $HWCONF -eq 3 ]
then
    export hw="arm64"
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
echo ""
echo "Number of video streams (^C to interrupt):"
declare -i STREAMS
read STREAMS
declare -i i=1
until test $i -gt $STREAMS
do
  echo "RTSP url address for video stream number $i:"
  read RTSP$i
  export RTSPurl=RTSP$i
  export contid=$i
  declare -i ip
  ip=$(( $i + 1 ))
  export ipnumber="172.21.0.$ip"
  export uuid=$(uuidgen)
  # create containers
  ( echo "cat <<EOF >docker-compose-temp$contid.yml";
  cat docker-compose-template.yml;
  ) >temp.yml
  . temp.yml
  cat docker-compose-temp$contid.yml > docker-compose-temp.yml;
  cat docker-compose-temp.yml >> docker-compose-containers.yml;
  rm -f docker-compose-temp$contid.yml temp.yml docker-compose-temp.yml;
  # create video input configuration
  ( echo "cat <<EOF >iotconf$contid";
  cat iotservice.properties-template;
  ) >temp
  . temp
  cat iotconf$contid > ./nscIotConfig/iotservice.properties$contid
  rm -f iotconf$contid temp
  i=$(( $i + 1 ))
done
cat docker-compose-header.yml docker-compose-containers.yml docker-compose-footer.yml > docker-compose.yml
rm -f docker-compose-containers.yml
echo "**********************************************************"
echo "New $hw based configuration is created for NSC Iot Client!"
echo "Number of video streams: $contid"
echo ""
echo "Start nscIotService by command:"
echo "sudo docker-compose up -d"
echo "**********************************************************"
