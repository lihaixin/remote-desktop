FROM alpine:3.12

ENV DISPLAY :0
ENV RESOLUTION=1024x768
ENV NOVNCHOME /root/noVNC

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk update \
 && apk add --no-cache xvfb x11vnc fluxbox supervisor xterm bash pcmanfm chromium firefox xrdp wqy-zenhei wget ca-certificates tar \
 && mkdir -p $NOVNCHOME/utils/websockify \
 && wget -qO- https://github.com/noVNC/noVNC/archive/master.tar.gz | tar xz --strip 1 -C $NOVNCHOME \
 && wget -qO- https://github.com/noVNC/websockify/archive/master.tar.gz | tar xz --strip 1 -C $NOVNCHOME/utils/websockify \
 && chmod +x -v /root/noVNC/utils/*.sh \
 && ln -s $NOVNCHOME/vnc_auto.html $NOVNCHOME/index.html \
 && apk del wget

ADD supervisord.conf /etc/supervisord.conf
ADD xrdp.ini /etc/xrdp/xrdp.ini
ADD menu /root/.fluxbox/menu
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 5901 6901 3389
ENTRYPOINT ["/bin/bash", "-c", "/entrypoint.sh"]
