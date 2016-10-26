#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

CONSUL_ADDR=${CONSUL_ADDR:-}

if [[ -z "${CONSUL_ADDR}" ]]
then
    echo "CONSUL_ADDR environment variable needs to be set (ex: localhost:8500)" > /dev/fd/2
    exit 255
fi

exec consul-template -config /data/consul-template.cfg -consul ${CONSUL_ADDR}
