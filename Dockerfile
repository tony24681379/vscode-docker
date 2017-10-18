FROM debian:8

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
    software-properties-common curl apt-transport-https \
    libc6-dev libgtk2.0-0 libgtk-3-0 libpango-1.0-0 libcairo2 \
    libfontconfig1 libgconf2-4 libnss3 libasound2 libxtst6 unzip \
    libglib2.0-bin libcanberra-gtk-module libgl1-mesa-glx \
    build-essential gettext libstdc++6 libsecret-tools \
    xterm automake libtool autogen libnotify-bin libxkbfile1 \
    aspell aspell-en htop gvfs-bin libxss1 rxvt-unicode-256color \
    x11-xserver-utils sudo git vim curl wget \
    && rm -rf /var/lib/apt/lists/*

RUN wget -O vscode-amd64.deb https://go.microsoft.com/fwlink/?LinkID=760868 \
    && dpkg -i vscode-amd64.deb \
    && rm vscode-amd64.deb 

# install flat plat theme
RUN wget 'https://github.com/nana-4/Flat-Plat/releases/download/3.20.20160404/Flat-Plat-3.20.20160404.tar.gz' \
    && tar -xf Flat-Plat* \
    && mv Flat-Plat /usr/share/themes \
    && rm Flat-Plat*gz \
    && mv /usr/share/themes/Default /usr/share/themes/Default.bak \
    && ln -s /usr/share/themes/Flat-Plat /usr/share/themes/Default

# install hack font
RUN wget 'https://github.com/chrissimpkins/Hack/releases/download/v2.020/Hack-v2_020-ttf.zip' \
    && unzip Hack*.zip \
    && mkdir /usr/share/fonts/truetype/Hack \
    && mv Hack* /usr/share/fonts/truetype/Hack \
    && fc-cache -f -v

COPY /developer /developer

RUN groupadd -r developer -g 1000 \
    && useradd -u 1000 -r -g developer -d /developer -s /bin/bash -c "Software Developer" developer \
    && echo "developer ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/developer \
    && chmod +x /developer/bin/* \
    && chown -R developer:developer /developer

WORKDIR /developer
USER developer
ENV SHELL /bin/bash

ENTRYPOINT ["/developer/bin/start.sh"]