FROM alpine:3.16.0
RUN apk add --no-cache \
        bash \
        curl \
        bind-tools

WORKDIR /opt/ext
ADD /scripts scripts

CMD ["bash", "/opt/ext/scripts/start.sh"]