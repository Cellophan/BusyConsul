#!/bin/sh

echo "searc dc1.consul
nameserver 127.0.0.1" >/etc/resolv.conf

exec consul agent -config-dir /app $@

