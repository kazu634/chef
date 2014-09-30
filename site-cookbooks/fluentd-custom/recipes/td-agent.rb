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

# deploy the `td-agent` configuration file for forwarding the logs
cookbook_file "/etc/td-agent/conf.d/forwarder.conf" do
  source "forwarder.conf"

  owner "root"
  group "root"

  mode  0644

  notifies :restart, "service[td-agent]"
end

# if the node accepts the forwarded logs
if node[:td_agent][:forward]
  # deploy the configuration file for accepting the forwarded logs
  cookbook_file "/etc/td-agent/conf.d/receiver.conf" do
    source "receiver.conf"

    owner "root"
    group "root"

    mode 0644

    notifies :restart, "service[td-agent]"
  end

  # allow access from 24224 port
  iptables_rule "receiver"
end

cookbook_file "/etc/monit/conf.d/td-agent.conf" do
  source "td-agent.monit"

  owner "root"
  group "root"

  mode  0644

  notifies :restart, "service[monit]"
end

# Enable `td-agent` to read the logs which cannot be opened by td-agent user.
bash "Execute td-agent as a root" do
  user "root"
  code <<-EOH
  sed -i 's/USER=td-agent/USER=root/' /etc/init.d/td-agent
  EOH
end
