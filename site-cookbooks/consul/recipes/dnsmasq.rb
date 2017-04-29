#
# Cookbook Name:: consul
# Recipe:: dnsmasq
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w(dnsmasq resolvconf).each do |s|
  service s do
    action :nothing
  end
end

cookbook_file '/etc/dnsmasq.conf' do
  owner 'root'
  group 'root'
  mode 0o644

  notifies :reload, 'service[dnsmasq]'
end

cookbook_file '/etc/resolvconf/resolv.conf.d/head' do
  owner 'root'
  group 'root'
  mode 0o644

  notifies :restart, 'service[resolvconf]'
end
