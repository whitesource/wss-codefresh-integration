FROM openjdk:8-jdk

RUN mkdir /wss-scan

COPY wss-runner.sh /wss-scan

RUN chmod +x /wss-scan/wss-runner.sh

CMD /wss-scan/wss-runner.sh $API_KEY $PROJECT_NAME $INSTALL_COMMANDS $CONFIG_FILE $PROJECT_DIRECTORY
