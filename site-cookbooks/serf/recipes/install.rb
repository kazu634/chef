#
# Cookbook Name:: serf
# Recipe:: install
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Download `serf`
remote_file node['serf']['tmp_path'] do
  source node['serf']['binary_url']

  owner node['serf']['user']
  group node['serf']['group']
  mode 00644

  action :create_if_missing
  backup false
end

# Unzip serf binary
execute 'unzip serf binary' do
  user node['serf']['user']
  cwd '/opt/serf/bin/'

  # -q = quiet, -o = overwrite existing files
  command "unzip -qo #{node['serf']['tmp_path']}"

  notifies :restart, 'service[serf]'
end

file '/opt/serf/bin/serf' do
  owner node['serf']['user']
  group node['serf']['group']

  mode 00755
end

# Add serf to /usr/bin so it is on our path
link '/usr/bin/serf' do
  to '/opt/serf/bin/serf'
end
