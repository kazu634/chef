From ubuntu:14.04

RUN sed -i "s/archive.ubuntu.com/jp.archive.ubuntu.com/" /etc/apt/sources.list && \
    apt-get update  && \
    apt-get install -y sudo openssh-server curl lsb-release && \
    apt-get install -y build-essential && \
    rm -rf /var/lib/apt/lists/* && \
    curl -L https://www.opscode.com/chef/install.sh | bash
