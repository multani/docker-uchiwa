FROM debian:jessie

RUN apt-get update \
    && apt-get install --yes --no-install-recommends \
       curl \
       ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV UCHIWA_VERSION 0.14.0-1
ENV UCHIWA_MD5 b9d073c23b96e565ed9492e1d4cfc41e

RUN curl -Ls http://dl.bintray.com/palourde/uchiwa/uchiwa_${UCHIWA_VERSION}_amd64.deb > /uchiwa.deb \
    && echo "${UCHIWA_MD5} /uchiwa.deb" | md5sum -c - \
    && dpkg -i /uchiwa.deb \
    && rm /uchiwa.deb

VOLUME /config

CMD ["/opt/uchiwa/bin/uchiwa", \
     "-p", "/opt/uchiwa/src/public/", \
     "-c", "/config/config.json"]

EXPOSE 3000