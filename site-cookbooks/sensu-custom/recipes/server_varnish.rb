#
# Cookbook Name:: sensu-custom
# Recipe:: server_settings
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

directory "/etc/varnish/sites/" do
  action :create

  owner  "root"
  group  "root"
  mode   0755
end

cookbook_file "/etc/varnish/sites/sensu-dashboard.vcl" do
  owner  "root"
  group  "root"
  mode   0644

  source "sensu-dashboard.vcl"

  notifies :create, "template[/etc/varnish/default.vcl]", :immediately
  notifies :restart, "service[varnish]", :delayed
end
