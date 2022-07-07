#!/bin/bash

#https://www.linuxjournal.com/content/validating-ip-address-bash-script
function valid_ipv4()
{
    local  ip=$1
    local  stat=1

    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
            && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        stat=$?
    fi
    return $stat
}

function cloudflare_ipv4()
{
    local ip=""
    ip=$(dig +short txt ch whoami.cloudflare @1.0.0.1 | tr -d '"')
    echo $ip
}

function google_ipv4()
{
    local ip=""
    ip=$(dig TXT +short o-o.myaddr.l.google.com @ns1.google.com | tr -d '"')
    echo $ip
}

function opendns_ipv4()
{
    local ip=""
    ip=$(dig +short myip.opendns.com @resolver1.opendns.com | tr -d '"')
    echo $ip
}