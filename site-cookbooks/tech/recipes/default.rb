#
# Cookbook Name:: tech
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "nginx"

user "tech" do
  home "/home/tech"
  shell "/bin/bash"
  password "$1$gE1b.NzY$/P8kwcxhOD2RZnw4lM.nz1"

  supports :manage_home => true
end

directory "/home/tech/.ssh" do
  owner "tech"
  group "tech"

  mode 0700
end

directory "/home/tech/public" do
  owner "tech"
  group "tech"

  mode 0755
end

directory "/var/www/nginx-default/domain" do
  owner "www-data"
  group "root"

  mode 0755
  recursive true
end

link "/var/www/nginx-default/domain/tech" do
  to "/home/tech/public"

  owner "www-data"
  group "root"
end

cookbook_file "/home/tech/.ssh/authorized_keys" do
  owner "tech"
  group "tech"

  mode 0600
end

template "/etc/nginx/sites-available/tech" do
  source "tech.erb"

  owner "root"
  group "root"

  mode 0644

  notifies :reload,  "service[nginx]"
end

link "/etc/nginx/sites-enabled/tech" do
  to "/etc/nginx/sites-available/tech"

  not_if "test -e /etc/nginx/sites-enabled/tech"
end

