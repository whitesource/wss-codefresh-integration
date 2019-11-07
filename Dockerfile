FROM whitesourcesoftware/ua-base:v1
RUN mkdir /wss-scan
COPY wss-runner.sh /wss-scan
COPY run_latest_jar.sh /wss-scan
RUN chmod +x /wss-scan/wss-runner.sh
RUN chmod +x /wss-scan/run_latest_jar.sh
CMD /wss-scan/wss-runner.sh $API_KEY $PROJECT_NAME $INSTALL_COMMANDS $CONFIG_FILE $PROJECT_DIRECTORY