#
# Cookbook Name:: base
# Recipe:: ssh
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "iptables"

iptables_rule "base_10022"

template "/etc/ssh/sshd_config" do
  source   "sshd_config.erb"

  owner    "root"
  group    "root"
  mode     0644

  notifies :restart, "service[ssh]"
end

service "ssh" do
    action :nothing
end
