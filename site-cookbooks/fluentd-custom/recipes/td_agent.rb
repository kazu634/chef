#
# Cookbook Name:: fluentd-custom
# Recipe:: td-agent
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'td-agent'

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

###################
# The Client part #
###################

# deploy the `td-agent` configuration file for forwarding the logs,
# only if the server is one of the clients.
template '/etc/td-agent/conf.d/forwarder.conf' do
  source 'forwarder.erb'

  owner 'root'
  group 'root'

  mode 0o644

  not_if { node['td_agent']['forward'] }

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

  # include the `iptables` cookbook
  include_recipe 'iptables'

  # allow access from 24224 port
  iptables_rule 'receiver'
end
