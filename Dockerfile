FROM debian:jessie

RUN apt-get update \
    && apt-get install --yes --no-install-recommends \
       curl \
       ca-certificates \
       unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV CONSUL_TEMPLATE_VERSION 0.16.0
ENV CONSUL_TEMPLATE_SHA256 064b0b492bb7ca3663811d297436a4bbf3226de706d2b76adade7021cd22e156

RUN curl -Ls https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip > /consul-template.zip \
    && echo "${CONSUL_TEMPLATE_SHA256} /consul-template.zip" | sha256sum -c - \
    && unzip /consul-template.zip consul-template -d /usr/local/bin/ \
    && rm /consul-template.zip


ENV UCHIWA_VERSION 0.16.0-1
ENV UCHIWA_MD5 c44c839096b8787679f9f291e29edb76

RUN curl -Ls http://dl.bintray.com/palourde/uchiwa/uchiwa_${UCHIWA_VERSION}_amd64.deb > /uchiwa.deb \
    && echo "${UCHIWA_MD5} /uchiwa.deb" | md5sum -c - \
    && dpkg -i /uchiwa.deb \
    && rm /uchiwa.deb

EXPOSE 3000

COPY consul-template.cfg config.json.ctmpl /data/
CMD consul-template -config /data/consul-template.cfg -consul ${CONSUL_ADDR}
