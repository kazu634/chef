#
# Cookbook Name:: consul
# Recipe:: prerequisites
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Make sure unzip is available to us
include_recipe 'supervisor::default'

# Make sure unzip is available to us
package 'unzip' do
  action :install
end

# Install `dnsmasq`:
package 'dnsmasq' do
  action :install
end

# `consul`-related paths:
%w(/etc/consul.d /var/opt/consul /opt/consul/bin).each do |d|
  directory d do
    owner 'root'
    group 'root'

    mode 0o755

    recursive true
    action :create
  end
end
