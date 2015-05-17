FROM progrium/busybox
MAINTAINER Cell <docker.cell@outer.systems>

RUN mkdir -p /app/data /app/ui /usr/local/bin &&\
    wget -O - http://dl.bintray.com/mitchellh/consul/0.5.1_linux_amd64.zip >/tmp/consul.zip &&\
    unzip /tmp/consul.zip -d /usr/local/bin &&\
    rm /tmp/consul.zip &&\
    wget -O - http://dl.bintray.com/mitchellh/consul/0.5.1_web_ui.zip >/tmp/web_ui.zip &&\
    unzip /tmp/web_ui.zip -d /app/ui &&\
    rm /tmp/web_ui.zip

ADD config.json /app/
ADD entrypoint.sh /

EXPOSE 8300 8301 8301/udp 8500 53 53/udp
ENTRYPOINT ["/entrypoint.sh"]

