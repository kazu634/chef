#
# Cookbook Name:: consul
# Recipe:: prerequisites
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Make sure unzip is available to us
package 'unzip' do
  action :install
end

# Create consul user/group
group node['consul']['group'] do
  action :create
end

user node['consul']['user'] do
  gid node['consul']['group']
  system true
  home '/nonexistent'
end

# `consul`-related paths:
%w(/etc/consul.d /var/opt/consul /opt/consul/bin).each do |d|
  directory d do
    owner node['consul']['user']
    group node['consul']['group']

    mode 0o755

    recursive true
    action :create
  end
end
