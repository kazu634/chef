#
# Cookbook Name:: fluentd-custom
# Recipe:: td-agent
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "chef-td-agent"
include_recipe "iptables"

directory "/etc/td-agent/conf.d" do
  owner "root"
  group "root"

  mode  0755
end

cookbook_file "/etc/td-agent/td-agent.conf" do
  source "td-agent.conf"

  owner "root"
  group "root"

  mode  0644

  notifies :restart, "service[td-agent]"
end

# if the node accepts the forwarded logs
if node[:td_agent][:forward]
  # deploy the configuration file for accepting the forwarded logs
  cookbook_file "/etc/td-agent/conf.d/forward.conf" do
    source "forward.conf"

    owner "root"
    group "root"

    mode 0644

    notifies :restart, "service[td-agent]"
  end

  # allow access from 24224 port
  iptables_rule "forward"
end

cookbook_file "/etc/monit/conf.d/td-agent.conf" do
  source "td-agent.monit"

  owner "root"
  group "root"

  mode  0644

  notifies :restart, "service[monit]"
end
