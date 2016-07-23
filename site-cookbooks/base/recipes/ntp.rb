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

if node['platform_version'].to_f < 16.04 then
  cookbook_file '/etc/ntp.conf' do
    owner 'root'
    group 'root'

    mode 0644

    notifies :restart, 'service[ntp]'
  end

elsif 16.04 == node['platform_version'].to_f then
  cookbook_file '/etc/ntp.conf' do
    owner 'root'
    group 'root'
    source 'ntp_1604.conf'

    mode 0644

    notifies :restart, 'service[ntp]'
  end
end


service 'ntp' do
  action :nothing
end
