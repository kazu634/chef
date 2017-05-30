#
# Cookbook Name:: fluentd-custom
# Recipe:: td-agent
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'td-agent'
include_recipe 'consul'

###################
# the common part #
###################

directory '/etc/td-agent/conf.d' do
  owner 'root'
  group 'root'

  mode 0o755
end

cookbook_file '/etc/td-agent/td-agent.conf' do
  source 'td-agent.conf'

  owner 'root'
  group 'root'

  mode 0o644

  notifies :restart, 'service[td-agent]'
end

cookbook_file '/etc/monit/conf.d/td-agent.conf' do
  source 'td-agent.monit'

  owner 'root'
  group 'root'

  mode 0o644

  notifies :restart, 'service[monit]'
end

group 'adm' do
  action :modify
  members 'td-agent'
  append true
end

# Deploy the hosts file:
template '/etc/hosts' do
  source 'hosts.erb'

  owner 'root'
  group 'root'

  mode 0o644
end

# deploy the `td-agent` configuration file for forwarding the logs,
cookbook_file '/etc/td-agent/conf.d/forwarder.conf' do
  source 'forwarder.conf'

  owner 'root'
  group 'root'

  mode 0o644

  notifies :restart, 'service[td-agent]'
end

# deploy the `td-agent` configuration file for monitoring `td-agent` logs
cookbook_file '/etc/td-agent/conf.d/forwarder_td-agent.conf' do
  source 'forwarder_td-agent.conf'

  owner 'root'
  group 'root'

  mode 0o644

  notifies :restart, 'service[td-agent]'
end

####################
# The Manager part #
####################

# if the node is the manager:
if node['td_agent']['forward']
  # deploy the configuration file for accepting the forwarded logs
  cookbook_file '/etc/td-agent/conf.d/receiver.conf' do
    source 'receiver.conf'

    owner 'root'
    group 'root'

    mode 0o644

    notifies :restart, 'service[td-agent]'
  end

  # deploy the configuration file for `consul`:
  template '/etc/consul.d/service-td-agent.json' do
    source 'service-td-agent.json'

    owner 'root'
    group 'root'

    mode 0o644

    notifies :run, 'bash[Reload supervisor]'
  end
  # include the `iptables` cookbook
  include_recipe 'iptables'

  # allow access from 24224 port
  iptables_rule 'receiver'
end
