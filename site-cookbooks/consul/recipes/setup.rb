#
# Cookbook Name:: consul
# Recipe:: setup
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Deploy `systemd` script:
cookbook_file '/lib/systemd/system/consul.service' do
  owner 'root'
  group 'root'
  mode 0o755
end

# Deploy default configuration file:
cookbook_file '/etc/default/consul' do
  owner 'root'
  group 'root'
  mode 0o644
end

# Deploy default `rsyslog` configuration file:
cookbook_file '/etc/rsyslog.d/22-consul.conf' do
  owner 'root'
  group 'root'
  mode 0o644

  notifies :run, 'bash[Restart rsyslogd]', :immediately
end

bash 'Restart rsyslogd' do
  code <<-EOH
  systemctl restart rsyslog.service
  EOH

  user  'root'
  group 'root'

  action :nothing
end

# Deploy the `consul` config file:
template '/etc/consul.d/config.json' do
  source 'consul.json.erb'

  owner node['consul']['user']
  group node['consul']['group']
  mode 0o644

  notifies :restart, 'service[consul]'
end

cookbook_file '/etc/consul.d/service-consul.json' do
  owner 'root'
  group 'root'
  mode 0o644

  only_if { node['consul']['manager'] }
  notifies :restart, 'service[consul]'
end

# Start `consul` service
service 'consul' do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end

# Configure `iptables` configuration:
include_recipe 'iptables'

iptables_rule 'consul'
