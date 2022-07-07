# Docker container that retrieves your external IP address via DIG
Gets external IP via DIG command ( opendns , cloudflare, google ) on a scheduled basis that can be customized. Also includes the ability to alert you via pushover if the IP changes.

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
        - PUSHOVER_TOKEN=False #optional
        - PUSHOVER_USER=user #optional
        - PUSHOVER_TITLE=pass #optional
```


| Parameter | Function |
|-----------|----------|
| `-e RECOVERY_ALERT=True/False`         |   (Optional) Used when NOTIFICATION_TYPE is set.<br><br> If the docker container cannot connect to the internet or retrieve an IP address a flag is set. Once the connection has been re-established or an IP address is retrieved a notification will be sent and the flag cleared. The IP address might be the same or different. If you do not wish to receive a notification when retrieving an IP fails mark it as FALSE. <br><br> Options: True, False    |
| `-e DELAY=5m`         |   (Optional) Using standard sleep command. <br><br> Options: X (X seconds), Xm (X minutes), Xh (5 hours), and Xd (days)     |
| `-e PROVIDER=CLOUDFLARE`         |   (Optional)<br><br>Options: CLOUDFLARE, GOOGLE, OPENDNS     |
| `-e NOTIFICATION_TYPE=PUSHOVER`         |   (Optional)<br><br>Options: PUSHOVER   |
| `-e PUSHOVER_TOKEN=`         |   (Required if NOTIFICATION_TYPE is set)   |
| `-e PUSHOVER_USER=`         |   (Required if NOTIFICATION_TYPE is set)    |
| `-e PUSHOVER_TITLE=`         |   (Optional) default message is "EXTERNAL IP"   |
