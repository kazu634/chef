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
