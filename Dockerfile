FROM progrium/busybox
MAINTAINER Cell <docker.cell@outer.systems>

RUN mkdir -p /app/data /app/ui &&\
    wget -O - http://dl.bintray.com/mitchellh/consul/0.5.1_linux_amd64.zip >/tmp/consul.zip &&\
    unzip /tmp/consul.zip -d /app &&\
    rm /tmp/consul.zip &&\
    wget -O - http://dl.bintray.com/mitchellh/consul/0.5.1_web_ui.zip >/tmp/web_ui.zip &&\
    unzip /tmp/web_ui.zip -d /app/ui &&\
    rm /tmp/web_ui.zip &&\
    echo -e '{\
     "client_addr": "0.0.0.0",\
     "data_dir": "/app/data",\
     "log_level": "WARN",\
     "domain": "consul.",\
     "ports": { "dns": 53 },\
     "ui_dir": "/app/ui",\
     "retry_join": ["consul"]\
}' >/app/config.json &&\
    echo -e "#!/bin/sh\nexec /app/consul agent -config-dir /app \$@" >/entrypoint.sh &&\
    chmod +x /entrypoint.sh

EXPOSE 8300 8301 8301/udp 850053 53/udp
ENTRYPOINT ["/entrypoint.sh"]

