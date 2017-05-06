#
# Cookbook Name:: fluentd-custom
# Recipe:: cron-apt
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# deploy the configuration file for monitoring /var/log/cron-apt/log
cookbook_file '/etc/td-agent/conf.d/forwarder_cron-apt.conf' do
  source 'forwarder_cron-apt.conf'

  owner 'root'
  group 'root'

  mode 0o644

  notifies :restart, 'service[td-agent]'
end
