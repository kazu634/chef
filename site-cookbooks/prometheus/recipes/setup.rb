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
%w(/etc/prometheus.d /etc/prometheus.d/targets/).each do |d|
  directory d do
    owner  'root'
    group  'root'
    mode   '0755'

    action :create
  end
end

# Deploy `prometheus` files:
cookbook_file '/etc/prometheus.d/prometheus.yml' do
  source 'prometheus.yml'

  owner  'root'
  group  'root'
  mode   0o644

  action :create
end

# Deploy temporary file for `prometheus` targets:
cookbook_file '/etc/prometheus.d/targets/targets.yml' do
  source 'targets.yml'

  owner  'root'
  group  'root'
  mode   0o644

  action :create
end

# Deploy template file for `consul-template` generating `prometheus` target file:
cookbook_file '/etc/consul-template.d/prometheus-targets.tmpl' do
  source 'prometheus-targets.tmpl'

  owner  'root'
  group  'root'
  mode   0o644

  action :create
end

# Deploy `supervisor` configuration for `prometheus-targets`, genarating `prometheus` targets:
cookbook_file '/etc/supervisor/conf.d/prometheus-targets.conf' do
  source 'prometheus-targets.conf'

  owner  'root'
  group  'root'
  mode   0o644

  action :create

  notifies :restart, 'service[supervisor]'
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

# Configure `iptables` configuration:
include_recipe 'iptables'

iptables_rule 'prometheus'
