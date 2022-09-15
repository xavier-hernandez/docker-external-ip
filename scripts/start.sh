#!/bin/bash
source $(dirname "$0")/lib/ipv4.sh
source $(dirname "$0")/lib/notify.sh

old_ip=0
recovery=0
sleep="5m"
regex="([[:digit:]]+$)|([[:digit:]]+d$)|([[:digit:]]+s$)|([[:digit:]]+m$)|([[:digit:]]+h$)"
recoveryAlert="[RECOVERY]"
changeAlert="[CHANGE]"

savedIPFile="/stor-external-ip/ip.saved"

echo -e "Starting..."
if [[ ${DELAY} =~ ${regex} ]]
then
    echo "Setting sleep delay..."
    sleep=${DELAY}
else
    echo -e "Bad parameter for DELAY, using default ${sleep}..."
fi

# load IP if saved
if [[ "${SAVEIP}" == "True" ]]; then
    if [[ -f "$savedIPFile" ]]; then
        while read line; do echo $old_ip; done < ${savedIPFile}
    else
        touch ${savedIPFile}
    fi
    if ! valid_ipv4 ${old_ip}; then
        echo -e "\n[Invalid Saved IP address]"
    fi
fi

while :
do
    if [[ "${PROVIDER}" == "CLOUDFLARE" ]]
    then
        ip=$(cloudflare_ipv4)
    elif [[ "${PROVIDER}" == "GOOGLE" ]]
    then
        ip=$(google_ipv4)
    elif [[ "${PROVIDER}" == "OPENDNS" ]]
    then
        ip=$(opendns_ipv4)
    else
        ip=$(cloudflare_ipv4)
    fi

    if valid_ipv4 ${ip}
    then
        #valid IP
        if [[ ${old_ip} != ${ip} || ${recovery} == 1 ]]
        then
            old_ip=${ip}
            if [[ ${recovery} == 1 ]]
            then
                echo -e "IP: ${ip} ${recoveryAlert}"
                if [[ ${RECOVERY_ALERT} == "True" ]]
                then
                    notify "IP: ${ip} ${recoveryAlert}"
                fi
            else
                echo -e "IP: ${ip} ${changeAlert}"
                notify "IP: ${ip} ${changeAlert}"
            fi
        else
            echo -e "IP: ${ip}"
        fi

        #save ip
        if [[ "${SAVEIP}" == "True" ]]; then
            echo ${ip} > ${savedIPFile}
        fi
        recovery=0
    else    
        #invalid IP
        echo -e "\n[Error or Invalid IP address]"
        recovery=1
    fi
    sleep ${sleep}
done