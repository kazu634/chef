#
# Cookbook Name:: prometheus
# Recipe:: node_exporter_setup
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Install `supervisor`:
include_recipe 'supervisor::default'

# Deploy `supervisor` configuration for `node_exporter`:
cookbook_file '/etc/supervisor/conf.d/node_exporter.conf' do
  source 'node_exporter.conf'

  owner  'root'
  group  'root'
  mode   0o644

  action :create

  notifies :restart, 'service[supervisor]'
end

# Configure `iptables` configuration:
include_recipe 'iptables'

iptables_rule 'node_exporter'
