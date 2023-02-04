ARG FROM_VER
FROM alpine:${FROM_VER:-3.16.2}

COPY requirements.apk requirements.apk
RUN xargs apk add --no-cache < requirements.apk

WORKDIR /app
COPY entrypoint.sh /app/entrypoint.sh
#CMD sleep inf
EXPOSE 25
VOLUME /var/spool/postfix
VOLUME /var/mail

CMD /app/entrypoint.sh
