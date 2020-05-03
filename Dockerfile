FROM ubuntu:18.04

# example 4.15.0: calibre_version="version=4.15.0"
# example latest: calibre_version=""
ARG calibre_version
ENV calibre_version=$calibre_version

LABEL maintainer="finios" \
      description="calibre-server"

RUN apt-get update && \
    apt-get -y install \
		wget \
		python \
		xz-utils \
		imagemagick \
		xdg-utils && \
    apt-get -y install --no-install-recommends \
		dbus \
		libnss3 \
		sqlite3 \
		bash-completion && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/src/*

RUN wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sh /dev/stdin ${calibre_version} && \
    rm /tmp/calibre* -Rf 2>&1 >/dev/null

WORKDIR /opt/calibre

COPY * /

RUN mkdir -p /calibre-lib && \
    mkdir -p /config && \
    chgrp -R 100 /calibre-lib && \
    chgrp -R 100 /config && \
    chmod -R 755 /calibre-lib && \
    chmod -R 755 /config && \
    chmod 755 /docker-entrypoint.sh

VOLUME ["/calibre-lib", "/config"]

EXPOSE 8080

ENV PORT=8080 \
    PREFIX="/" \
    LIBRARY="/calibre-lib" \
    USERDB="server-users.sqlite" \
    AUTH="disable-auth" \
    AUTH_USER="root" \
    AUTH_PASSWORD="root" \
    BANAFTER=5 \
    BANFOR=30 \
    AJAXTIMEOUT=60 \
    TIMEOUT=120 \
    NUMPERPAGE=50 \
    MAXOPDS=30 \
    OTHERPARAM= \
    CALIBRE_OVERRIDE_LANG="en" \
    CALIBRE_CONFIG_DIRECTORY="/config/calibre"

ENTRYPOINT /docker-entrypoint.sh
CMD [""]
