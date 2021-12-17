FROM alpine:edge

ENV DISPLAY :0
ENV RESOLUTION=1024x768

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk update
RUN apk add --no-cache xvfb x11vnc fluxbox supervisor xterm bash pcmanfm chromium firefox xrdp wqy-zenhei novnc websockify

RUN ln -s /usr/share/novnc/vnc_lite.html /usr/share/novnc/index.html \

ADD supervisord.conf /etc/supervisord.conf
ADD xrdp.ini /etc/xrdp/xrdp.ini
ADD menu /root/.fluxbox/menu
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 5901 6901 3389
ENTRYPOINT ["/bin/bash", "-c", "/entrypoint.sh"]
