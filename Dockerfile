ARG FROM_VER
FROM alpine:${FROM_VER:-3.16.2}

RUN apk add --no-cache \
        postfix

CMD sleep inf
