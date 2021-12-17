FROM alpine:3.12

ENV DISPLAY :0
ENV RESOLUTION=1024x768
ENV NOVNCHOME /root/noVNC
ENV TZ=Asia/Shanghai

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
 && apk update \
 && apk add --no-cache xvfb x11vnc fluxbox supervisor xterm bash pcmanfm chromium firefox xrdp wqy-zenhei wget ca-certificates tar tzdata figlet curl neofetch \
 && apk add --no-cache ttf-ubuntu-font-family font-adobe-100dpi font-noto ttf-dejavu font-isas-misc \
 && mkdir -p $NOVNCHOME/utils/websockify \
 && wget -qO- https://github.com/noVNC/noVNC/archive/v1.2.0.tar.gz | tar xz --strip 1 -C $NOVNCHOME \
 && wget -qO- https://github.com/noVNC/websockify/archive/v0.10.0.tar.gz | tar xz --strip 1 -C $NOVNCHOME/utils/websockify \
 && chmod +x -v /root/noVNC/utils/*.sh \
 && ln -s $NOVNCHOME/vnc.html $NOVNCHOME/index.html \
 && ln -s /usr/bin/python3 usr/bin/python \
 && apk del wget

ADD supervisord.conf /etc/supervisord.conf
ADD xrdp.ini /etc/xrdp/xrdp.ini
ADD menu /root/.fluxbox/menu
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 5901 6901 3389
ENTRYPOINT ["/bin/bash", "-c", "/entrypoint.sh"]
