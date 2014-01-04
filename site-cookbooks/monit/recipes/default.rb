#
# Cookbook Name:: monit
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "monit" do
  action :install
end

service "monit" do
  action :disable
end

cookbook_file "/etc/monit/monitrc" do
  source "monitrc"
  mode   0600
  owner "root"
  group "root"

  notifies :reload, "service[monit]"
end

template "/etc/init/monit.conf" do
  source   "monit.conf.erb"
  mode     0644
  owner    "root"
  group    "root"

  notifies :run, "script[initctl reload-configuration]"
end

script "initctl reload-configuration" do
  interpreter "bash"

  user "root"
  group "root"

  code <<-EOH
  /etc/init.d/monit stop && update-rc.d -f monit remove
  initctl reload-configuration
  EOH

  action :nothing
end
