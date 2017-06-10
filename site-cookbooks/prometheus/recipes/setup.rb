#
# Cookbook Name:: prometheus
# Recipe:: setup
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Install `supervisor`:
include_recipe 'supervisor::default'

# Create `/etc/prometheus.d/`:
directory '/etc/prometheus.d/' do
  owner  'root'
  group  'root'
  mode   '0755'

  action :create
end

# Deploy `prometheus` files:
cookbook_file '/etc/prometheus.d/prometheus.yml' do
  source 'prometheus.yml'

  owner  'root'
  group  'root'
  mode   0o644

  action :create
end

# Deploy `supervisor` configuration for `prometheus`:
cookbook_file '/etc/supervisor/conf.d/prometheus.conf' do
  source 'prometheus.conf'

  owner  'root'
  group  'root'
  mode   0o644

  action :create

  notifies :restart, 'service[supervisor]'
end
