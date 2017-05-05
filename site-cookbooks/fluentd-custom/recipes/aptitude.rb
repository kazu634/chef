#
# Cookbook Name:: fluentd-custom
# Recipe:: aptitude
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# deploy the configuration file for monitoring /var/log/apt/history.log
cookbook_file '/etc/td-agent/conf.d/forwarder_aptitude.conf' do
  source 'forwarder_aptitude.conf'

  owner 'root'
  group 'root'

  mode 0o644

  notifies :restart, 'service[td-agent]'
end
