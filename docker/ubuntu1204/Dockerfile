From ubuntu:12.04

RUN sed -i "s/archive.ubuntu.com/jp.archive.ubuntu.com/" /etc/apt/sources.list

RUN apt-get update
RUN apt-get install -y sudo openssh-server curl lsb-release

RUN curl -L https://www.opscode.com/chef/install.sh | bash
