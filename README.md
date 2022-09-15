# Docker container that retrieves your external IP address via DIG with optional pushover alert and Apprise support
Gets external IP via DIG command ( opendns , cloudflare, google ) on a scheduled basis that can be customized. Also includes the ability to alert you via pushover if the IP changes.

Example from docker logs
```
Starting...
Setting sleep delay...
IP: 00.00.00.00 [CHANGE]

Sending pushover message...
{"status":1,"request":"gfdgdf-gdfg-gdfgd-dfgd-fgdfgd"}

IP: 00.00.00.00
dig: couldn't get address for 'ns1.google.com': not found

[Error or Invalid IP address]
dig: couldn't get address for 'ns1.google.com': not found

[Error or Invalid IP address]
IP: 00.00.00.00 [RECOVERY]
IP: 00.00.00.00
IP: 00.00.00.01 [CHANGE]

Sending pushover message...
{"status":1,"request":"gfdgdf-gdfg-gdfgd-dfgd-fgdfgd"}

IP: 00.00.00.01
```
---

## **Docker**
- Image: https://hub.docker.com/r/xavierh/external-ip
- OS/ARCH
  - linux/amd64
  - linux/arm/v7
  - linux/arm64/v8
- Tags: https://hub.docker.com/r/xavierh/external-ip/tags
  - stable - xavierh/external-ip:latest

## **Github Repo**   
- https://github.com/xavier-hernandez/docker-external-ip

---

**Built-In Pushover Example**
```yml
external_ip:
    image: xavierh/external-ip:latest
    container_name: external_ip
    restart: always
    environment:
        - TZ=America/New_York
        - RECOVERY_ALERT=True/False #optional, default is False
        - DELAY=5m #optional, default is 5 minutes
        - PROVIDER=CLOUDFLARE #optional, default is cloudflare
        - NOTIFICATION_TYPE=PUSHOVER #optional
        - PUSHOVER_TOKEN=token #optional
        - PUSHOVER_USER=user #optional
        - PUSHOVER_TITLE=title #optional, if using PUSHOVER
        - SAVE_IP=True #optional
    volume:
        - /path/to/data:/stor-external-ip #optional but required if using SAVE_IP
```
**APPRISE Example**
```yml
external_ip:
    image: xavierh/external-ip:latest
    container_name: external_ip
    restart: always
    environment:
        - TZ=America/New_York
        - RECOVERY_ALERT=True/False #optional, default is False
        - DELAY=5m #optional, default is 5 minutes
        - PROVIDER=CLOUDFLARE #optional, default is cloudflare
        - NOTIFICATION_TYPE=APPRISE #optional
        - APPRISE_TITLE=title #optional, if using APPRISE
        - APPRISE_1=pover://user@token #required if using APPRISE
        - APPRISE_2=pushed://appkey/appsecret/ #optional
        - APPRISE_3=discord://webhook_id/webhook_token #optional
        - APPRISE_...=pover://user@token #optional, up to 10
```


| Parameter | Function |
|-----------|----------|
| `-e RECOVERY_ALERT=True/False`         |   (Optional) Used when NOTIFICATION_TYPE is set.<br><br> If the docker container cannot connect to the internet or retrieve an IP address a flag is set. Once the connection has been re-established or an IP address is retrieved a notification will be sent and the flag cleared. The IP address might be the same or different. If you do not wish to receive a notification when retrieving an IP fails mark it as FALSE. <br><br> Options: True, False    |
| `-e DELAY=5m`         |   (Optional) Using standard sleep command. <br><br> Options: X (X seconds), Xm (X minutes), Xh (5 hours), and Xd (days)     |
| `-e PROVIDER=CLOUDFLARE`         |   (Optional)<br><br>Options: CLOUDFLARE, GOOGLE, OPENDNS     |
| `-e NOTIFICATION_TYPE=PUSHOVER`         |   (Optional)<br><br>Options: PUSHOVER,APPRISE   |
| `-e PUSHOVER_TOKEN=`         |   (Required if NOTIFICATION_TYPE is set)   |
| `-e PUSHOVER_USER=`         |   (Required if NOTIFICATION_TYPE is set)    |
| `-e PUSHOVER_TITLE=`         |   (Optional) default message is "EXTERNAL IP"   |
| `-e APPRISE_TITLE=`         |   (Optional) default message is "EXTERNAL IP"   |
| `-e APPRISE_1=`         |   (1 is required) the app will read up to 10, i.e. APPRISE_2... APPRISE_10, use syntax from CLI syntax https://github.com/caronc/apprise  |