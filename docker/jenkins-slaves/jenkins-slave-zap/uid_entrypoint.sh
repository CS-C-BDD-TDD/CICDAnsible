#!/bin/bash

if ! whoami &> /dev/null; then
  if [ -w /etc/passwd ]; then
    echo "Storing container UID in /etc/passwd to support ZAP"
    echo "${USER_NAME:-default}:x:$(id -u):0:${USER_NAME:-default} user:${HOME}:/sbin/nologin" >> /etc/passwd
  fi
fi

# Execute the provided command with arguments AFTER the UID setup
# Run the process in the background and output the PID
$@