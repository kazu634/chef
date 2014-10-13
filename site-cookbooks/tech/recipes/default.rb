#
# Cookbook Name:: tech
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "nginx"

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

