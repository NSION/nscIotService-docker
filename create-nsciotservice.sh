#!/bin/bash
# Attach iot-key file name
for keyfile in `ls ./iotkey`; do
export iotkey=$keyfile
done
#if keyfile=NULL then echo "Iot key is missing!"; exit
export contid="1"
export ipnumber="172.21.0.2"
export uuid=$(uuidgen)
rm -f docker-compose.yml temp.yml     
( echo "cat <<EOF >docker-compose.yml";
  cat docker-compose-template.yml;
  echo "EOF";
) >temp.yml
. temp.yml
cat docker-compose.yml
