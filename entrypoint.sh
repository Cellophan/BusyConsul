#!/bin/sh

nameserver="$(awk '/^nameserver/{ print $2; }' /etc/resolv.conf | head -1)"
echo "{ \"recursors\": [ \"${nameserver:-8.8.4.4}\" ] }" >/consul/config/recursors.json

echo "search service.dc1.consul
nameserver 127.0.0.1" >/etc/resolv.conf

exec consul agent -config-dir /consul/config $@

