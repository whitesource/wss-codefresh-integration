FROM openjdk:8-jdk
RUN echo "111"
RUN mkdir /wss-scan
RUN echo "222"
COPY wss-runner.sh /wss-scan
RUN echo "333"
RUN chmod +x /wss-scan/wss-runner.sh
RUN echo "444"
CMD /wss-scan/wss-runner.sh $API_KEY $PROJECT_NAME $INSTALL_COMMANDS $CONFIG_FILE $PROJECT_DIRECTORY
