ARG S6_ARCH
FROM oznu/s6-node:14.15.1-arm64

RUN apk add --no-cache git python2 python3 make g++ avahi-compat-libdns_sd avahi-dev dbus \
    iputils sudo nano \
  && chmod 4755 /bin/ping \
  && mkdir /homebridge \
  && npm set global-style=true \
  && npm set audit=false \ 
  && npm set fund=false

RUN esac \
    && set -x \
    && curl -Lfs https://github.com/oznu/ffmpeg-for-homebridge/releases/download/v0.0.9/ffmpeg-alpine-armv6l.tar.gz | tar xzf - -C / --no-same-owner

ENV PATH="${PATH}:/homebridge/node_modules/.bin"

ENV HOMEBRIDGE_VERSION=1.2.4
RUN npm install -g --unsafe-perm homebridge@1.2.4

ENV CONFIG_UI_VERSION=4.35.0 HOMEBRIDGE_CONFIG_UI=0 HOMEBRIDGE_CONFIG_UI_PORT=8080
RUN npm install -g --unsafe-perm homebridge-config-ui-x@4.36.0

WORKDIR /homebridge
VOLUME /homebridge

COPY root /

ARG AVAHI
ENV ENABLE_AVAHI="${AVAHI:-0}"
