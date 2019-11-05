#!/bin/bash
echo "echo printing env"
env
echo ""
LOCAL_INSTALL_FILE="install-commands.sh"
echo "*******************************************************************************************************************"
echo "                          Start Executing Commands File"
echo "*******************************************************************************************************************"
echo ""

if [[ -f ${COMMANDS_FILE_PATH} ]]
then
    echo "Executing file: $COMMANDS_FILE_PATH"
    echo ""
    ./${COMMANDS_FILE_PATH}
else
    echo "Couldn't find file $COMMANDS_FILE_PATH trying to download file from  URL"
	curl -LJO ${COMMANDS_FILE_PATH}
	if [[ -f ${LOCAL_INSTALL_FILE} ]]
	then
		chmod +x ${LOCAL_INSTALL_FILE}
		./${LOCAL_INSTALL_FILE}
	else
		echo "unable to download or find file from ${COMMANDS_FILE_PATH}, skipping ${LOCAL_INSTALL_FILE} file"
	fi
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
CONFIG_FILE_PATH=${CONFIG_FILE_PATH:="wss-unified-agent.config"}

if [[ -z "${API_KEY}" ]]; then
    bash <(curl -s -L https://github.com/whitesource/unified-agent-distribution/raw/master/standAlone/wss_agent_scanner.sh) -c "${CONFIG_FILE_PATH}" -d "${DIRECTORY}"
else
    bash <(curl -s -L https://github.com/whitesource/unified-agent-distribution/raw/master/standAlone/wss_agent_scanner.sh) -apiKey "${API_KEY}" -c "${CONFIG_FILE_PATH}" -d "${DIRECTORY}"
fi

echo ""
echo "*******************************************************************************************************************"
echo "				Finish Running WhiteSource Unified Agent       "
echo "*******************************************************************************************************************"
