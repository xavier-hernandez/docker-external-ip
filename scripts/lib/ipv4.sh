#!/bin/bash

# Script to handle IPv4 Addresses

# Replace all instances of 'APIFY' with 'IPIFY'

function replace_apify() {
    sed -i 's/APIFY/IPIFY/g' some_file.txt
}

# Call the function
replace_apify
