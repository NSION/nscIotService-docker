#!/bin/bash
# Get list of stream
workdir=$HOME/nscIotService-docker/nscIotConfig
echo "*************************************************************"
echo "List of rtsp url addresses configured per camera: "
echo ""
find $workdir -type f | sort -n  | while read -r line ; 
	do    
		rtsp=$(sed -n 's/.*\(rtsp.*\).*/\1/p' $line;)
		url=$(echo $rtsp | sed 's/[\]//g';)
		id=$(echo $line | sed 's/.*\(.\)$/\1/';)
		printf "camera$id: $url \n"; 
	done
echo ""
