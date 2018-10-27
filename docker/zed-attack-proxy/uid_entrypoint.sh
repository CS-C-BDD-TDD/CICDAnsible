#!/bin/bash

if ! whoami &> /dev/null; then
  if [ -w /etc/passwd ]; then
    echo "Storing container UID in /etc/passwd to support ZAP"
    echo "${USER_NAME:-default}:x:$(id -u):0:${USER_NAME:-default} user:${HOME}:/sbin/nologin" >> /etc/passwd
  fi
fi

zap-x.sh -daemon -host 0.0.0.0 -port -8080 -config api.addrs.addr.name=.* -config api.addrs.addr.regex=true