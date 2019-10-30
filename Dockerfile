FROM ubuntu:16.04
 
# Image containing:
# 1.  Ubuntu:16.04
# 2.  Java (1.8.0_161)
# 3.  Maven (3.5.4)
# 4.  Node.js (8.9.4)
# 5.  NPM (5.6.0)
# 6.  Bower (1.8.2)
# 7.  Yarn (1.5.1)
# 8.  Go (1.10.2)
# 9.  Ruby()
# 10. Gradle (4.5.1)
# 11. Unzip
# 12. Pip3
# 13. Pip
# 14. SBT
# 15. Scala
 
RUN touch /buildStart.txt && \
  apt-get update && \
  apt-get install -y --no-install-recommends locales && \
  locale-gen en_US.UTF-8 && \
  apt-get dist-upgrade -y && \
  echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" > /etc/apt/sources.list.d/webupd8team-java-trusty.list && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886 && \
  apt-get update && \
  apt-get clean all
 
# Install curl wget and openjdk 8
RUN apt-get -y install software-properties-common && \
  add-apt-repository -y ppa:openjdk-r/ppa && \
  apt-get update && \
  apt-get -y install openjdk-8-jdk && \
  apt-get install -y wget && \
  apt-get install -y curl && \
  rm -rf /var/lib/apt/lists/*
 
# Install git
RUN apt-get update && apt-get install -y git
 
# Install Maven (3.5.4)
ARG MAVEN_VERSION=3.5.4
ARG USER_HOME_DIR="/root"
ARG SHA=CE50B1C91364CB77EFE3776F756A6D92B76D9038B0A0782F7D53ACF1E997A14D
ARG BASE_URL=https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries
 
RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
  && curl -fsSL -o /tmp/apache-maven.tar.gz ${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
  && echo "${SHA}  /tmp/apache-maven.tar.gz" | sha256sum -c - \
  && tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
  && rm -f /tmp/apache-maven.tar.gz \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn
 
ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"
 
# Install Node.js (8.9.4) + NPM (5.6.0)
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash && \
    apt-get install -y nodejs build-essential
 
# Install Bower
RUN npm i -g bower --allow-root
 
# Premmsion to bower
RUN echo '{ "allow_root": true }' > /root/.bowerrc
 
# Install Yarn
RUN npm i -g yarn@1.5.1
 
# Install unzip files
RUN apt-get update && apt-get install -y unzip zip
 
#install Gradle
RUN wget -q https://services.gradle.org/distributions/gradle-4.5.1-bin.zip \
    && unzip gradle-4.5.1-bin.zip -d /opt \
    && rm gradle-4.5.1-bin.zip
 
# Set Gradle in the environment variables
ENV GRADLE_HOME /opt/gradle-4.5.1
ENV PATH $PATH:/opt/gradle-4.5.1/bin
 
# Install python pip
RUN apt-get install -y python3-pip
RUN apt-get install -y python-pip
RUN python -m pip install --upgrade pip setuptools
RUN pip install virtualenv
 
####Install GO####
RUN \
mkdir -p /goroot && \
curl https://storage.googleapis.com/golang/go1.10.2.linux-amd64.tar.gz | tar xvzf - -C /goroot --strip-components=1
 
####Install Ruby####
RUN \
apt-get update && \
apt-get install -y ruby ruby-dev ruby-bundler && \
rm -rf /var/lib/apt/lists/*
 
RUN apt-get update
RUN apt-get install -y --force-yes build-essential curl git
RUN apt-get install -y --force-yes zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev
RUN apt-get clean
 
####Set GO environment variables####
ENV GOROOT /goroot
ENV GOPATH /gopath
ENV PATH $GOROOT/bin:$GOPATH/bin:$PATH
 
####Install GO package managers####
RUN go get -u github.com/golang/dep/cmd/dep
RUN go get github.com/tools/godep
RUN go get github.com/LK4D4/vndr
RUN go get -u github.com/kardianos/govendor
RUN go get -u github.com/gpmgo/gopm
RUN go get github.com/Masterminds/glide
 
####Install Scala####
RUN wget https://downloads.lightbend.com/scala/2.12.6/scala-2.12.6.deb --no-check-certificate
RUN dpkg -i scala-2.12.6.deb
 
####Install SBT####
RUN curl -L -o sbt.deb http://dl.bintray.com/sbt/debian/sbt-1.1.6.deb
RUN dpkg -i sbt.deb
RUN apt-get update && \
    apt-get install sbt
 
 
 
COPY pipe /usr/bin/
ENTRYPOINT ["/usr/bin/pipe.sh"]
