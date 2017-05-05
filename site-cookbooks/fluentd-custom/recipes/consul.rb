#
# Cookbook Name:: fluentd-custom
# Recipe:: consul
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# deploy the configuration file for monitoring /var/log/consul.log
cookbook_file '/etc/td-agent/conf.d/forwarder_consul.conf' do
  source 'forwarder_consul.conf'

  owner 'root'
  group 'root'

  mode 0o644

  notifies :restart, 'service[td-agent]'
end
