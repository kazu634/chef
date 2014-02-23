#
# Cookbook Name:: jenkins
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apt"
include_recipe "nginx"
include_recipe "base"

pre_requisites = %w{python-demjson ca-certificates-java default-jre-headless
                    icedtea-6-jre-cacao icedtea-6-jre-jamvm java-common libavahi-client3
                    libavahi-common-data libavahi-common3 libcups2 libnspr4 libnss3 libnss3-1d
                    libpcsclite1 openjdk-6-jre-headless openjdk-6-jre-lib tzdata-java}

pre_requisites.each do |p|
  package p do
    action :install
  end
end

apt_repository "jenkins" do
  uri "http://pkg.jenkins-ci.org/debian"

  components ["binary/"]

  key "http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key"

  not_if "test -e /usr/share/jenkins/jenkins.war"
end

remote_file "#{Chef::Config[:file_cache_path]}/jenkins.deb" do
  source `apt-get --allow-unauthenticated -y install --print-uris jenkins | cut -d\\' -f2 | grep http:// | grep jenkins | head -1`.chomp

  mode 0666

  not_if "test -e /usr/share/jenkins/jenkins.war"
end

script "Install jenkins" do
  interpreter "bash"

  cwd Chef::Config['file_cache_path']

  code <<-EOF
  dpkg -i jenkins.deb
  EOF

  not_if "test -e /usr/share/jenkins/jenkins.war"
end

service "jenkins" do
  action [:start, :enable]
end

package "ttf-dejavu" do
  action :install
end

template "/etc/nginx/sites-available/jenkins" do
  source   "jenkins.erb"

  user     "root"
  group    "root"
  mode     0644

  notifies :restart, "service[nginx]"
end

link "/etc/nginx/sites-enabled/jenkins" do
  to "/etc/nginx/sites-available/jenkins"

  not_if "test -e /etc/nginx/sites-enabled/jenkins"
end

service "nginx" do
  action :nothing
end

include_recipe "jenkins::docker"
include_recipe "jenkins::env"
