#!/bin/bash

if [[ -n $1 ]]; then
    echo "param provided to script, deleting projects postfixed with $1"
    oc delete project yellowdog$1 yellowdog-demo$1 labs-demo$1
else
    echo "no param provided to script, deleting default projects"
    oc delete project yellowdog yellowdog-demo labs-demo
fi
