FROM debian:jessie

RUN apt-get update \
    && apt-get install --yes --no-install-recommends \
       curl \
       ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV UCHIWA_VERSION 0.14.2-1
ENV UCHIWA_SHA1 8ebd3ae61c372f04d7c309743213775d8be1f15d

RUN curl -Ls http://dl.bintray.com/palourde/uchiwa/uchiwa_${UCHIWA_VERSION}_amd64.deb > /uchiwa.deb \
    && echo "${UCHIWA_SHA1} /uchiwa.deb" | sha1sum -c - \
    && dpkg -i /uchiwa.deb \
    && rm /uchiwa.deb

VOLUME /config

CMD ["/opt/uchiwa/bin/uchiwa", \
     "-p", "/opt/uchiwa/src/public/", \
     "-c", "/config/config.json"]

EXPOSE 3000
