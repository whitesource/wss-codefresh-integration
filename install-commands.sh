# #!/bin/bash

# Add bash commands to update and customize the "whitesource-scan".

# Upon starting "whitesource-scan" container these commands will be executed to align the environment
# with all required packages and libraries.

#-----------------------------------------------------------------------------------------------------
#                                    EXAMPLE
#-----------------------------------------------------------------------------------------------------

# # Update Install Packages
# apt-get update
# apt-get update && apt-get install -y --no-install-recommends ca-certificates curl wget

# # Set Environment Variables
# PYTHON_VERSION=2.7.13
# PYTHON_PIP_VERSION=9.0.1

# # Download Packages
# wget  https://github.com/whitesource/unified-agent-distribution/blob/master/standAlone/wss-unified-agent.jar
