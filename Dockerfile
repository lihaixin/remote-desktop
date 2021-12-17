FROM alpine:edge
ENV PASSWORD=admin
ENV DISPLAY :0
ENV RESOLUTION=1024x768

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk update
RUN apk add --no-cache xvfb x11vnc fluxbox supervisor xterm bash sudo pcmanfm chromium firefox xrdp wqy-zenhei novnc websockify

RUN ln -s /usr/share/novnc/vnc_lite.html /usr/share/novnc/index.html \
    && addgroup admin \
    && adduser  -G admin -s /bin/sh -D admin \
    && echo "admin:admin" | /usr/sbin/chpasswd \
    && echo "admin    ALL=(ALL) ALL" >> /etc/sudoers
    

ADD supervisord.conf /etc/supervisord.conf
ADD xrdp.ini /etc/xrdp/xrdp.ini
ADD menu /home/admin/.fluxbox/menu
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 5901 6901 3389
USER admin
ENTRYPOINT ["/bin/bash", "-c", "/entrypoint.sh"]
