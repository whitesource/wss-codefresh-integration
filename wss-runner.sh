#!/bin/bash

echo ""
LOCAL_INSTALL_FILE="install-commands.sh"
echo "*******************************************************************************************************************"
echo "                          Start Executing Commands File"
echo "*******************************************************************************************************************"
echo ""

if [[ -f ${COMMANDS_FILE_PATH} ]]
then
    echo "Executing file: ${COMMANDS_FILE_PATH}"
    echo ""
    ./${COMMANDS_FILE_PATH}
else
    echo "Couldn't find file $COMMANDS_FILE_PATH , Skipping installing extra commands before running scan"
fi

echo ""
echo "*******************************************************************************************************************"
echo "                          Finish Executing Commands File"
echo "*******************************************************************************************************************"


echo ""
echo ""
echo "*******************************************************************************************************************"
echo "				Start Running WhiteSource Unified Agent       "
echo "*******************************************************************************************************************"
echo ""

DIRECTORY=${DIRECTORY:="."}
API_KEY=${API_KEY}
CONFIG_FILE_PATH=${CONFIG_FILE_PATH:="/codefresh/volume/wss-unified-agent.config"}

if [[ -z "${API_KEY}" ]]; then
    ./wss-scan/run_latest_jar.sh -c "${CONFIG_FILE_PATH}" -d "${DIRECTORY}"
else
    ./wss-scan/run_latest_jar.sh -apiKey "${API_KEY}" -c "${CONFIG_FILE_PATH}" -d "${DIRECTORY}"
fi

echo ""
echo "*******************************************************************************************************************"
echo "				Finish Running WhiteSource Unified Agent       "
echo "*******************************************************************************************************************"