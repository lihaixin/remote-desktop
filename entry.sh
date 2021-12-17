#!/bin/sh

if [ "$PASSWORD" ]; then
    echo "alpine:$PASSWORD" | /usr/sbin/chpasswd \
    sed -i "s/^\(command.*x11vnc.*\)$/\1 -passwd '$PASSWORD'/" /etc/supervisord.conf
fi

/usr/bin/supervisord
