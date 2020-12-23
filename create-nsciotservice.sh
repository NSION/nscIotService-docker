#!/bin/bash
# Move old files
mv docker-compose.yml docker-compose.old
# Remove old rtsp configuration files
rm ./nscIotConfig/*
# Attach iot-key file name
for keyfile in `ls ./iotkey`; do
export iotkey=$keyfile
done
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
echo "New configuration is created for NSC Iot Client!"
echo "Number of video streams: $contid"
echo ""
echo "Start nscIotService by command:"
echo "sudo docker-compose up -d"
