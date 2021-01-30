#!/bin/bash
# Get list of streams
workdir=$HOME/nscIotService-docker/nscIotConfig
echo "*************************************************************"
echo "NSC3 Broadcasting status per camera sourcs:"
echo ""
find $workdir -type f | sort -n  | while read -r line ; 
	do    
		id=$(echo $line | sed 's/.*\(.\)$/\1/';)
        statusjson=$(wget -qO- http://localhost:809$id/nscIotService/status/streaming;)
        if [ -z "$statusjson" ]
        then
            status="No broadcasting status"
        else
            status=$statusjson
        fi
		printf "camera$id: $status \n"; 
	done
echo ""
