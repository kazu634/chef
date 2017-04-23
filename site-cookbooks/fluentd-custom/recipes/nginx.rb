#
# Cookbook Name:: fluentd-custom
# Recipe:: nginx
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Install prerequisite gems
%w( fluent-plugin-s3 ).each do |pkg|
  td_agent_gem pkg do
    action :upgrade
  end
end

# deploy the configuration file for monitoring nginx logs
cookbook_file '/etc/td-agent/conf.d/forwarder_nginx.conf' do
  source 'forwarder_nginx.conf'

  owner 'root'
  group 'root'

  mode 0644

  notifies :restart, 'service[td-agent]'
end

# deploy the configuration file for processing nginx logs
s3_auth = Chef::EncryptedDataBagItem.load('fluentd-custom', 's3')

template '/etc/td-agent/conf.d/processor_nginx.conf' do
  source 'processor_nginx.conf.erb'

  owner 'root'
  group 'root'

  mode 0644

  variables(
    aws_key_id: s3_auth['aws_key_id'],
    aws_sec_key: s3_auth['aws_sec_key']
  )

  # if the node is the fluentd manager:
  only_if { node['td_agent']['forward'] }

  notifies :restart, 'service[td-agent]'
end
