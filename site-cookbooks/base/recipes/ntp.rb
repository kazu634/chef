#
# Cookbook Name:: base
# Recipe:: ntp
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'ntp' do
  action :install
end

cookbook_file '/etc/ntp.conf' do
  owner 'root'
  group 'root'

  mode 0644

  notifies :restart, 'service[ntp]'
end

service 'ntp' do
  action :nothing
end
