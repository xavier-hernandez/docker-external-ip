#!/bin/bash

# Script to get external IP

EXTERNAL_IP=$(curl -s http://api.ipify.org)

# Output the external IP
echo "External IP: $EXTERNAL_IP"