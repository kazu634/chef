#
# Cookbook Name:: consul
# Recipe:: setup
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Deploy the `supervisor` config file:
cookbook_file '/etc/supervisor/conf.d/consul.conf' do
  source 'consul.supervisor'

  owner 'root'
  group 'root'

  mode 0o644

  notifies :restart, 'service[supervisor]'
end

# Deploy the `consul` config file:
template '/etc/consul.d/config.json' do
  source 'consul.json.erb'

  owner 'root'
  group 'root'
  mode 0o644
end

cookbook_file '/etc/consul.d/service-consul.json' do
  owner 'root'
  group 'root'

  mode 0o644

  only_if { node['consul']['manager'] }
end

# Monit integration:
include_recipe 'monit'

cookbook_file '/etc/monit/conf.d/consul.conf' do
  owner 'root'
  group 'root'

  mode 0o644

  notifies :restart, 'service[monit]'
end

# Start `consul` service
bash 'Reload supervisor' do
  user 'root'
  group 'root'

  code <<-EOH
    /usr/bin/supervisorctl update
  EOH
end

# Configure `iptables` configuration:
include_recipe 'iptables'

iptables_rule 'consul'
