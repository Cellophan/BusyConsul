FROM progrium/busybox
MAINTAINER Cell <docker.cell@outer.systems>

RUN mkdir -p /consul/ui /consul/bin /consul/config /usr/local/bin &&\
    wget -O - http://dl.bintray.com/mitchellh/consul/0.5.1_linux_amd64.zip >/tmp/consul.zip &&\
    unzip /tmp/consul.zip -d /consul/bin &&\
    rm /tmp/consul.zip &&\
    ln -s /consul/bin/* /usr/local/bin/ &&\
    wget -O - http://dl.bintray.com/mitchellh/consul/0.5.1_web_ui.zip >/tmp/web_ui.zip &&\
    unzip /tmp/web_ui.zip -d /consul/ui &&\
    rm /tmp/web_ui.zip

ADD config.json /consul/config/
ADD entrypoint.sh /

EXPOSE 8300 8301 8301/udp 8500 53 53/udp
ENTRYPOINT ["/entrypoint.sh"]

