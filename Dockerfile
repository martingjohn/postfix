ARG FROM_VER
FROM alpine:${FROM_VER:-3.16.2}

RUN apk add --no-cache \
        bash \
        postfix

WORKDIR /app
COPY entrypoint.sh /app/entrypoint.sh
CMD sleep inf
