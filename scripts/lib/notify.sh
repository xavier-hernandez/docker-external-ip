#!/bin/bash

function notify()
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
    elif [[ "${NOTIFICATION_TYPE}" == "APPRISE" ]]; then
        if [[ -z ${APPRISE_TITLE} ]]
        then
            APPRISE_TITLE="EXTERNAL IP"
        fi
        echo -e "\nSending notification via Apprise..."

        for i in {1..10}
        do
            combo_notify="${NOTIFICATION_TYPE}_${i}"
            if [[ -n ${!combo_notify} ]]
            then
                apprise -vv -t "${APPRISE_TITLE}" -b "${1}" "${!combo_notify}"
            fi
        done
    fi
}