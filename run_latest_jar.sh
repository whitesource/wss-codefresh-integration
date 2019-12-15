#!/bin/bash

curl -LJO https://github.com/whitesource/unified-agent-distribution/releases/latest/download/wss-unified-agent.jar

java -jar wss-unified-agent.jar "$@"

# fail build if exit code is not 0
exitCode=$?
if [ $exitCode != 0 ]
then
   exit 1
fi
exit $exitCode