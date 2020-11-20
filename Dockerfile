FROM alpine:edge

LABEL maintainer="Jan Kuri <jan@bleenco.com>"

ENV DISPLAY :99
ENV RESOLUTION 1920x1080x24 

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
	&& echo "http://mirrors.ustc.edu.cn/alpine/edge/testing" >> /etc/apk/repositories \
    && apk add --no-cache ca-certificates curl openssl sudo xvfb x11vnc xfce4 faenza-icon-theme bash \
    && adduser -h /home/alpine -s /bin/bash -S -D alpine && echo -e "alpine\nalpine" | passwd alpine \
    && echo 'alpine ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER alpine
WORKDIR /home/alpine

RUN mkdir -p /home/alpine/.vnc && x11vnc -storepasswd alpine /home/alpine/.vnc/passwd

COPY entry.sh /entry.sh

CMD [ "/bin/bash", "/entry.sh" ]
