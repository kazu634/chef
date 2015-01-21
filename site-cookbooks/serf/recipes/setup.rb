#
# Cookbook Name:: serf
# Recipe:: setup
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Download sample configuration file:
remote_file '/etc/serf/serf.json.example' do
  source 'https://raw.githubusercontent.com/hashicorp/serf/master/ops-misc/debian/serf.json.example'

  owner node['serf']['user']
  group node['serf']['group']
  mode 00644
end

# Download init.d script:
remote_file '/etc/init.d/serf' do
  source 'https://raw.githubusercontent.com/hashicorp/serf/master/ops-misc/debian/serf.init'

  owner 'root'
  group 'root'
  mode 00755
end

# Download upstart configuration file:
remote_file '/etc/init/serf.conf' do
  source 'https://raw.githubusercontent.com/hashicorp/serf/master/ops-misc/debian/serf.upstart'

  owner 'root'
  group 'root'
  mode 00644
end

# Deploy the `serf` config file:
if node['serf']['manager']
  cookbook_file '/etc/serf/serf.json' do
    owner node['serf']['user']
    group node['serf']['group']
    mode 00644

    notifies :restart, 'service[serf]'
  end

  cookbook_file '/etc/serf/handlers/handler.rb' do
    owner node['serf']['user']
    group node['serf']['group']
    mode 00755
  end

  %w( growthforecast slack-notify ).each do |gem|
    gem_package gem do
      action :upgrade
      gem_binary '/opt/chef/embedded/bin/gem'
    end
  end
else
  template '/etc/serf/serf.json' do
    source 'serf.json.erb'

    owner node['serf']['user']
    group node['serf']['group']
    mode 00644

    notifies :restart, 'service[serf]'
  end
end

# Start agent service
service 'serf' do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end

# Configure `iptables` configuration, unless in testing.
if node['serf']['iptables']
  include_recipe 'iptables'
  iptables_rule 'serf'
end
