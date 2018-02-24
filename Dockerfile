FROM ubuntu:16.04
MAINTAINER finios

RUN apt-get update && apt-get dist-upgrade -y
RUN apt-get -y install wget python git xz-utils imagemagick xdg-utils
RUN rm /tmp/calibre* -Rf 2>&1 >/dev/null && wget -nv -O- https://download.calibre-ebook.com/linux-installer.py | python -c "import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main()"

WORKDIR /opt/calibre

RUN mkdir -p /calibre-lib

VOLUME ["/calibre-lib"]
EXPOSE 8080
ENV PREFIX /
ENV LIBRARY /calibre-lib

CMD /opt/calibre/calibre-server --url-prefix=$PREFIX  --userdb /users.sqlite --enable-auth --port=8080 "$LIBRARY" 
