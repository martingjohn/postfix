FROM ubuntu:16.04

ENV FQDN mail.home

RUN    echo postfix postfix/main_mailer_type string "'No configuration'" | debconf-set-selections \
    && echo postfix postfix/mailname string ${FQDN} | debconf-set-selections \
    && apt-get update && apt-get install -y \
            parallel \
            postfix \
            rsyslog \
            runit \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /orig

RUN rm -rf /etc/sv/getty-5
RUN rm -rf /etc/rsyslog.d /etc/rsyslog.conf
RUN rm /etc/postfix/main.cf
RUN touch /etc/postfix/main.cf
RUN mv /etc/postfix /orig/postfix

ADD rsyslog.conf /etc/rsyslog.conf

ADD rsyslog.init /etc/sv/rsyslog/run
ADD postfix.init /etc/sv/postfix/run
ADD start.sh /usr/local/bin/start.sh

RUN chmod +x /etc/sv/*/run
RUN chmod +x /usr/local/bin/start.sh

# enable all runit services
RUN ln -s /etc/sv/* /etc/service

EXPOSE 25

VOLUME "/etc/postfix"

CMD [ "/usr/local/bin/start.sh" ]
