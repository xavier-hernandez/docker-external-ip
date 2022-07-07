#!/bin/bash

function pushover()
{
    if [[ "${NOTIFICATION_TYPE}" == "PUSHOVER" ]]
    then
        if [[ -z ${PUSHOVER_TITLE} ]]
        then
            PUSHOVER_TITLE="EXTERNAL IP"
        fi

        echo -e "\nSending pushover message..."

        curl -s \
        -F "token=${PUSHOVER_TOKEN}" \
        -F "user=${PUSHOVER_USER}" \
        -F "message=${1}" \
        -F "title=${PUSHOVER_TITLE}" \
        https://api.pushover.net/1/messages

        echo -e "\n"
    fi
}