FROM ubuntu:20.04

ARG JENKINS_TAG=master

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies and clean up after installation
RUN apt-get update && apt-get install -y \
    apt-utils \
    git \
    openjdk-17-jdk \
    wget \
    tar \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# Install Maven 4.0.0-rc-1
RUN wget https://downloads.apache.org/maven/maven-4/4.0.0-rc-1/binaries/apache-maven-4.0.0-rc-1-bin.tar.gz && \
    tar -xzf apache-maven-4.0.0-rc-1-bin.tar.gz && \
    mv apache-maven-4.0.0-rc-1 /opt/maven && \
    rm apache-maven-4.0.0-rc-1-bin.tar.gz && \
    ln -s /opt/maven/bin/mvn /usr/bin/mvn

# Clone Jenkins repository, build, and move the war file
RUN git clone https://github.com/jenkinsci/jenkins.git && \
    cd jenkins && \
    git checkout ${JENKINS_TAG} && \
    mvn clean package -DskipTests -T 1C && \
    if [ -f war/target/jenkins.war ]; then \
      mv war/target/jenkins.war /opt/jenkins.war; \
    fi && rm -rf ../jenkins

# Expose port 8080
EXPOSE 8080

# Run Jenkins
CMD ["java", "-jar", "/opt/jenkins.war"]
