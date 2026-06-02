
KAV_NETWORK_SERVICES=('HomeNetworkMonitoring' 'httpscan' 'ids' 'SafeBanking')
ACTION='NONE'

ACTION_OUTCOME='OK'

case $@ in
    start) ACTION='START';;
    stop) ACTION='STOP';;
    status) ACTION='STATUS';;
esac

function perform_action() {
    CHECK_STATUS='OK'
    local TARGET_ACTION=$1
    shift
    local TARGET_SERVICES=("$@")
    
    
    for service_name in ${TARGET_SERVICES[@]}; do
        if [[ "$TARGET_ACTION" =~ 'status' ]]; then
            echo "$(sudo kav status $service_name)"
            continue
        fi
        
        echo "Attempting action $TARGET_ACTION on ${service_name}."
        sudo kav $TARGET_ACTION $service_name

        ACTION_RESULT="$(sudo kav status $service_name | awk '{print $2;}' )"
        if [[ $ACTION_RESULT -eq 'disabled' ]]; then 
            ACTION_RESULT='stop'
        elif [[ $ACTION_RESULT -eq 'running' ]] || [[ $ACTION_RESULT -eq 'enabled' ]]; then
            ACTION_RESULT='start'
        elif [[ $ACTION_RESULT -eq 'failed' ]]; then
            ACTION_RESULT='failed'
        fi

        if [[ "$TARGET_ACTION" =~ "$ACTION_RESULT" ]]; then
            echo "Performing $TARGET_ACTION on $service_name was sucessful."
        else
            CHECK_STATUS='ERROR'

            echo "$TARGET_ACTION $service_name failed"
            echo "Current status of service:"
            echo "$(sudo kav status $service_name)"
        fi
        done
    if [[ $CHECK_STATUS == 'ERROR' ]]; then
        echo "ERROR: Performing $TARGET_ACTION did not succeed on all services!"
        ACTION_OUTCOME='ERROR'
    else
        echo "\n\nPerform $TARGET_ACTION on servives completed sucessfully."
    fi
}

if [[ "$ACTION" =~ 'NONE' ]]; then
    echo "USAGE: $0 action"
    echo "  Valid actions are start, stop, and status."
    echo
elif [[ "$ACTION" =~ 'START' ]]; then
    sudo launchctl start /Library/LaunchDaemons/com.kaspersky.sysextctrld.plist
    perform_action "start" "${KAV_NETWORK_SERVICES[@]}"
    echo "You will likely need to open networl preferences and connect 'Kaspersky Filter' and 'Kaspersky Monitor'\n"
elif [[ "$ACTION" =~ 'STOP' ]]; then
    perform_action "stop" "${KAV_NETWORK_SERVICES[@]}"
    if [[ "$ACTION_OUTCOME" =~ 'OK' ]]; then
        sudo launchctl unload /Library/LaunchDaemons/com.kaspersky.sysextctrld.plist
        echo "You will likely need to open networ preferences and disconnect 'Kaspersky Filter' and 'Kaspersky Monitor'\n"
    fi
elif [[ "$ACTION" =~ 'STATUS' ]]; then
    perform_action "status" "${KAV_NETWORK_SERVICES[@]}"
fi
