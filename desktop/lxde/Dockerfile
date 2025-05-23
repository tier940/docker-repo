FROM --platform=$BUILDPLATFORM docker.io/debian:12
LABEL maintainer="tier940"

ENV DEBIAN_FRONTEND=noninteractive
ARG TARGETOS TARGETARCH
ENV USER=vncuser
ENV PASSWORD=vncpass

RUN apt-get update && apt-get install -y \
    task-lxde-desktop \
    tigervnc-standalone-server \
    tigervnc-common \
    xterm \
    dbus-x11 \
    x11-xserver-utils \
    xauth \
    sudo \
    bash-completion \
    fonts-noto-cjk \
    --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash ${USER} && \
    usermod -aG sudo ${USER} && \
    echo "${USER} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USER} && \
    chmod 0440 /etc/sudoers.d/${USER}

RUN mkdir -p /home/${USER}/.vnc && \
    echo "$PASSWORD" | vncpasswd -f > /home/${USER}/.vnc/passwd && \
    chmod 600 /home/${USER}/.vnc/passwd && \
    chown -R ${USER}:${USER} /home/${USER}

RUN echo '#!/bin/bash\n\
export DISPLAY=:1\n\
touch /home/${USER}/.Xauthority\n\
export XAUTHORITY=/home/${USER}/.Xauthority\n\
xauth -f /home/${USER}/.Xauthority add :1 . $(mcookie)\n\
vncserver -geometry 1366x768 -depth 24 -SecurityTypes VncAuth -localhost no :1\n\
startlxde &\n\
tail -f /dev/null' > /home/${USER}/vnc_start.sh && \
    chmod +x /home/${USER}/vnc_start.sh && \
    chown ${USER}:${USER} /home/${USER}/vnc_start.sh

EXPOSE 5901
WORKDIR /home/${USER}
CMD ["/bin/bash", "-c", "/home/${USER}/vnc_start.sh"]
USER ${USER}
