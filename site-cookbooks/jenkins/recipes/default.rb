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

package "python-demjson" do
  action :install
end

apt_repository "jenkins" do
  uri "http://pkg.jenkins-ci.org/debian"

  components ["binary/"]

  key "http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key"

  not_if "test -e /usr/share/jenkins/jenkins.war"
end

package "jenkins" do
  action :install

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

include_recipe "jenkins::env"
