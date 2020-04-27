FROM ubuntu
MAINTAINER RDPanek "rdpanek@gmail.com"

LABEL io.k8s.description="VNC Container based on Ubuntu" \
    io.k8s.display-name="VNC Container based on Ubuntu" \
    io.openshift.expose-services="5901:xvnc" \
    io.openshift.tags="vnc, ubuntu, xfce" \
    io.openshift.non-scalable=true

ENV DISPLAY=:1 \
    VNC_PORT=5901 

EXPOSE $VNC_PORT

### Envrionment config
ENV USER=root \
    HOME=/root \
    DEBIAN_FRONTEND=noninteractive \
    VNC_COL_DEPTH=24 \
    VNC_RESOLUTION=1280x1024 \
    VNC_PW=ratata \
    PASSWD_PATH="$HOME/.vnc/passwd"

### Install dependencies
RUN apt update && apt install -y \
    xfce4 \
    xfce4-goodies \
    xfce4-terminal \
    tightvncserver \
    default-jre \
    git \
    tig \
    htop && \
    apt clean -y

### Setup VNC
RUN mkdir -p "$HOME/.vnc" && \
    PASSWD_PATH="$HOME/.vnc/passwd" && \
    echo $VNC_PW | vncpasswd -f >> $PASSWD_PATH \
    && chmod 600 $PASSWD_PATH

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

WORKDIR /${HOME}
ENTRYPOINT ["/docker-entrypoint.sh"]