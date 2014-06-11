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
  case node["platform"]
  when "ubuntu"
    if node["platform_version"].to_f >= 13.10
      provider Chef::Provider::Service::Upstart
    end
  end

  action :nothing
end
