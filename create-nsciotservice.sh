#!/bin/bash
export container-nr="1"
export ip-number="172.21.0.2"
export uuid="39acc406-2393-78f7-0e59-b383c096c265"
export iot-key="test.iot"
rm -f docker-compose.yml temp.yml     
( echo "cat <<EOF >docker-campose.yml";
  cat docker-compose-template.yml;
  echo "EOF";
) >temp.yml
. temp.yml
cat docker-compose.yml