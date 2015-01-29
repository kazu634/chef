#
# Cookbook Name:: sensu-custom
# Recipe:: client_settings
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

sensu_client `uname -n`.chomp do
  address node['ipaddress']
  subscriptions ['all']
end

cookbook_file '/etc/sudoers.d/sensu' do
  source 'sensu'

  owner 'root'
  group 'root'
  mode 0440
end

cookbook_file '/etc/monit/conf.d/sensu-client.conf' do
  source 'sensu-client.conf'

  owner 'root'
  group 'root'
  mode 0644

  notifies :reload, 'service[monit]'
end
