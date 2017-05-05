#
# Cookbook Name:: fluentd-custom
# Recipe:: processor
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# deploy the configuration file for slack notification
cookbook_file '/etc/td-agent/conf.d/processor.conf' do
  source 'processor.conf'

  owner 'root'
  group 'root'

  mode 0o644

  only_if { node['td_agent']['forward'] }

  notifies :restart, 'service[td-agent]'
end
