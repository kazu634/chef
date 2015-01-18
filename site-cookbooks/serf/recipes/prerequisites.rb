#
# Cookbook Name:: serf
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

# Create serf user/group
group node['serf']['group'] do
  action :create
end

user node['serf']['user'] do
  gid node['serf']['group']
  system true
  home '/nonexistent'
end

# `serf` storage path: `/opt/serf`
%w( /opt/serf /opt/serf/bin ).each do |d|
  directory d do
    owner node['serf']['user']
    group node['serf']['group']

    mode 00755

    recursive true
    action :create
  end
end

# `serf` configuration path: `/etc/serf`
%w( /etc/serf /etc/serf/handlers ).each do |d|
  directory d do
    owner node['serf']['user']
    group node['serf']['group']

    mode 00755

    recursive true
    action :create
  end
end
