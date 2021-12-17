#!/bin/sh

if [ "$PASSWORD" ]; then
    sed -i "s/^\(command.*x11vnc.*\)$/\1 -passwd '$PASSWORD'/" /etc/supervisord.conf
fi

/usr/bin/supervisord
