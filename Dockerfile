FROM debian:jessie

RUN apt-get update \
    && apt-get install --yes --no-install-recommends \
       curl \
       ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


ENV DUMB_INIT_VERSION 1.2.0

RUN curl -Ls https://github.com/Yelp/dumb-init/releases/download/v${DUMB_INIT_VERSION}/dumb-init_${DUMB_INIT_VERSION}_amd64.deb > /dumb-init.deb\
    && dpkg -i /dumb-init.deb \
    && rm /dumb-init.deb

ENV UCHIWA_VERSION 0.21.0-1
ENV UCHIWA_MD5 920ca35674cbe31f8b43f5b5dce018e7

RUN curl -Ls http://dl.bintray.com/palourde/uchiwa/uchiwa_${UCHIWA_VERSION}_amd64.deb > /uchiwa.deb \
    && echo "${UCHIWA_MD5} /uchiwa.deb" | md5sum -c - \
    && dpkg -i /uchiwa.deb \
    && rm /uchiwa.deb

VOLUME /config

CMD ["/opt/uchiwa/bin/uchiwa", \
     "-p", "/opt/uchiwa/src/public/", \
     "-c", "/config/config.json"]

EXPOSE 3000
