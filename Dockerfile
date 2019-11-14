FROM whitesourcesoftware/ua-base:v1
COPY wss-runner.sh .
COPY run_latest_jar.sh .
RUN chmod +x /wss-runner.sh
RUN chmod +x /run_latest_jar.sh
CMD /wss-runner.sh $API_KEY $PROJECT_NAME $INSTALL_COMMANDS $CONFIG_FILE $PROJECT_DIRECTORY