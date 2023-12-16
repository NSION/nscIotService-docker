#!/bin/bash

# Your CLI tool name
CLI_NAME="nscIoTClient-CLI.sh"
# Runtime parameters
IOTHOSTNAME="localhost"
IOTPORT="8090"
TIMESTAMP=$(date +%Y%m%d%H%M)
SUDO=false

# Function to display help
function display_help() {
    echo "Usage: $CLI_NAME [OPTIONS] COMMAND [ARGS]"
    echo ""
    echo "Options:"
    echo "  -h, --help        Show this help message and exit"
    echo ""
    echo "Commands:"
    echo "  status            nscIoTClient status"
    echo "  list              List of streaming devices"
    echo "  add               Add new streaming sources"
    echo "    Arguments:      e.g 'add -name testcam -url rtsp://test.com:554 -u test -p mypass'"
    echo "    -name           Name of stream source "
    echo "    -url            URL address for streaming port "
    echo "    -u              Camera user authentication: user. If no user credentials then -u '' "
    echo "    -p              Camera user authentication: password. If no passwd credentials then -p '' "
    echo "  remove            Remove streaming source"
    echo "    Arguments:      e.g 'remove -sourceID 4911a9a5-f6af-4ee0-aa50-75e61f9d67c9'"
    echo "    -sourceID       ID of stream source, list of streaming sources by 'list' command"
    echo "  iotkey            Add or update new iot-key"
    echo "    Arguments:      e.g 'iotkey -location /home/ubuntu/test.nsc.iot'"
    echo "    -location       Location and file name of iotkey"      
    echo "  control           Start/Stop video stream"
    echo "    Arguments:      e.g 'control -sourceID 4911a9a5-f6af-4ee0-aa50-75e61f9d67c9 start'"
    echo "    -sourceID       ID of stream source, list of streaming sources by 'list' command"
    echo "    start/stop      options: start or stop"
    echo "  optimize          Optimize video quality. Options value or default. Argument 'default' means no-changes"
    echo "    Arguments:      e.g (only fps) 'optimize -fps 10 -framewidth default -frameheight default'"
    echo "    -fps            Frames per second, 'default' as camera source, usually value '25'"
    echo "    -framewidth     FRAME_WIDTH, 'default' as camera source, HD(p720) e.g '1280'"
    echo "    -frameheight    FRAME_HEIGHT, 'default' as camera source, HD(p720) e.g '720'" 
}

# Function for status
function status() {
    # echo "Executing status command with arguments: $@"
    # Add your status logic here
    export IOTCONNECTIONSTATUS=$(curl -s http://$IOTHOSTNAME:$IOTPORT/status/streaming | jq -r '.connectionStatus')
    export IOTSTEAMINGSTATUS=$(curl -s http://$IOTHOSTNAME:$IOTPORT/status/streaming | jq -r '.liveStreaming')
    export IOTKEYSTATUS=$(curl -s http://$IOTHOSTNAME:$IOTPORT/connection/access-configuration-status | jq -r '.accessConfigurationStatus')
    if [ -z "$IOTKEYSTATUS" ]
        then
        echo "nscIoT Service is down. Please try to restart by 'docker-compose up -d'"
        else 
        if [ $IOTKEYSTATUS != "SUCCESS" ]
            then
            echo "Please add iotkey by 'nscIoTClient-CLI.sh iotkey' command"
            else
            echo "Connection status to NSC3 server = $IOTCONNECTIONSTATUS"
            echo "Streaming status to NSC3 server = $IOTSTEAMINGSTATUS"
        fi
    fi
}
# Function for list
function list() {
    # echo "Executing list command with arguments: $@"
    # Add your list logic here
    echo "name,streamSourceId,type,address,autostart,broadcastStatus"
    curl -s http://$IOTHOSTNAME:$IOTPORT/inputsource/list | jq -r '.sources[] | [.name, .streamSourceId, .type, .address, .autostart, .broadcastStatus] | @csv' 2> /dev/null
}
# Function for add
function add() {
    echo "Executing add command with arguments: '$@'"
    if  [ $1 == "-name" ]; then NAME=$2; else invalid $@; exit 1; fi
    if  [ $3 == "-url" ]; then URL=$4; else invalid $@; exit 1; fi
    if  [ $5 == "-u" ]; then US=$6; else invalid $@; exit 1; fi
    if  [ $7 == "-p" ]; then PSSWD=$8; else invalid $@; exit 1; fi
    if  [[ -z "$US" || -z "$PSSWD" ]]; then URL2=$URL; else URL2=$(echo $URL | sed "s~://~://$US:$PSSWD@~"); fi
    # echo "add syntax ok: $NAME $URL $US $PSSWD $URL2" 
    FEEDBACK=$(curl -X POST http://$IOTHOSTNAME:$IOTPORT/inputsource/addNetwork -H "Content-Type: application/json" -d '{"networkAddress":"'$URL2'","newName":"'$NAME'"}' 2> /dev/null)
    echo $FEEDBACK
    echo "Starting new camera..."
    SOURCEID=$(echo $FEEDBACK | sed 's/.* \([^ ]*\)$/\1/')
    sleep 5
    FEEDBACK2=$(curl -X POST http://$IOTHOSTNAME:$IOTPORT/inputsource/$SOURCEID/start 2> /dev/null)
    echo $FEEDBACK2
}
# Function for remove
function remove() {
    echo "Executing remove command with arguments: '$@'"
    if  [ $1 == "-sourceID" ]; then SOURCEID=$2; else invalid $@; exit 1; fi
    # echo "remove syntax ok: $SOURCEID" 
    STOP=$(curl -X POST http://$IOTHOSTNAME:$IOTPORT/inputsource/$SOURCEID/stop 2> /dev/null)
    FEEDBACK=$(curl -X DELETE http://$IOTHOSTNAME:$IOTPORT/inputsource/$SOURCEID 2> /dev/null)
    echo $FEEDBACK
}
# Function for iotkey
function iotkey() {
    echo "Executing iotkey command with arguments: '$@'"
    if  [ $1 == "-location" ]; then IOTKEY=$2; else invalid $@; exit 1; fi
    if [ -f "$IOTKEY" ]; then 
        echo "The iot-key found from '$IOTKEY'"
        cp $IOTKEY ./iotconfig/. 2> /dev/null 
        if test "$SUDO" = true; then sudo docker-compose restart; else docker-compose restart; fi
        sleep 10
        IOTKEYSTATUS=$(curl -s http://$IOTHOSTNAME:$IOTPORT/connection/access-configuration-status | jq -r '.accessConfigurationStatus')
        if [ -z "$IOTKEYSTATUS" ]
            then
            echo "nscIoT Service is down. Please try to restart by 'docker-compose up -d'"
            else
            echo "Connection status with new iotkey = $IOTKEYSTATUS"
        fi
        else
        echo "The iot-key cannot been found from '$IOTKEY'"
    fi
}
# Function for control
function control() {
    echo "Executing control command with arguments: '$@'"
    if  [ $1 == "-sourceID" ]; then SOURCEID=$2; else invalid $@; exit 1; fi
    if  [[ $3 == "start"  ||  $3 == "stop" ]]; then COMMAND=$3; else invalid $@; exit 1; fi
    echo "control syntax ok: $SOURCEID $COMMAND" 
    FEEDBACK=$(curl -X POST http://$IOTHOSTNAME:$IOTPORT/inputsource/$SOURCEID/$COMMAND 2> /dev/null)
    echo $FEEDBACK
}
# Function for optimize
function optimize() {
    echo "Executing optimize command with arguments: '$@'"
    # make backup env file
    mv ./iotconfig/nscIoTConf.env ./iotconfig/nscIoTConf-$TIMESTAMP.env 2> /dev/null
    touch ./iotconfig/nscIoTConf.env
    if  [ $1 == "-fps" ]; then FPS=$2; else invalid $@; exit 1; fi
    if  [ $3 == "-framewidth" ]; then FRAME_WIDTH=$4; else invalid $@; exit 1; fi
    if  [ $5 == "-frameheight" ]; then FRAME_HEIGHT=$6; else invalid $@; exit 1; fi
    if  [ $FPS == "default" ]; then NSC3_IOT_SERVICE_LIVE_FRAMERATE=""; else NSC3_IOT_SERVICE_LIVE_FRAMERATE=$FPS; fi
    if  [ $FRAME_WIDTH == "default" ]; then NSC3_IOT_SERVICE_LIVE_FRAME_WIDTH=""; else NSC3_IOT_SERVICE_LIVE_FRAME_WIDTH=$FRAME_WIDTH; fi
    if  [ $FRAME_HEIGHT == "default" ]; then NSC3_IOT_SERVICE_LIVE_FRAME_HEIGHT=""; else NSC3_IOT_SERVICE_LIVE_FRAME_HEIGHT=$FRAME_HEIGHT; fi
    echo "NSC3_IOT_SERVICE_LIVE_FRAMERATE=$NSC3_IOT_SERVICE_LIVE_FRAMERATE" >> ./iotconfig/nscIoTConf.env
    echo "NSC3_IOT_SERVICE_LIVE_FRAME_WIDTH=$NSC3_IOT_SERVICE_LIVE_FRAME_WIDTH" >> ./iotconfig/nscIoTConf.env
    echo "NSC3_IOT_SERVICE_LIVE_FRAME_HEIGHT=$NSC3_IOT_SERVICE_LIVE_FRAME_HEIGHT" >> ./iotconfig/nscIoTConf.env
    if test "$SUDO" = true; then sudo docker-compose restart; else docker-compose restart; fi
    echo "New optimize parameters: Framerate=$FPS, FRAME_WIDTH=$FRAME_WIDTH, FRAME_HEIGHT=$FRAME_HEIGHT. nscIoTService restarted!" 
}
function invalid() {
    echo "Invalid syntax: '$@' "
    echo "Please check valid arguments by --help"
    # Add your list logic here
}
# Main function to parse arguments and dispatch commands
function main() {
    if [ "$#" -eq 0 ]; then
        display_help
        exit 1
    fi

    case "$1" in
        -h|--help)
            display_help
            ;;
        status)
            shift
            status "$@"
            ;;
        list)
            shift
            list "$@"
            ;;
        add)
            shift
            add "$@"
            ;;
        remove)
            shift
            remove "$@"
            ;;
        iotkey)
            shift
            iotkey "$@"
            ;;
        control)
            shift
            control "$@"
            ;;
        optimize)
            shift
            optimize "$@"
            ;;
        invalid)
            shift
            invalid "$@"
            exit 1
            ;;
        *)
            echo "Error: Unknown command '$1'"
            display_help
            exit 1
            ;;
    esac
}

# Run the main function with command-line arguments
main "$@"
