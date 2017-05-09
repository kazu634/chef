#
# Cookbook Name:: consul
# Recipe:: monitoring
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Install `nagios-plugins`:
package 'nagios-plugins' do
  action :install

  options '--no-install-recommends'
end

# Deploy the check-file script:
cookbook_file '/usr/lib/nagios/plugins/check_file' do
  source 'check_file'
  owner 'root'
  group 'root'
  mode 0o555

  notifies :reload, 'service[consul]'
end

# Deploy `consul` monitoring config file:
%w(disk load ssh swap reboot-required).each do |target|
  cookbook_file "/etc/consul.d/check-#{target}.json" do
    owner node['consul']['user']
    group node['consul']['group']

    mode 0o644

    notifies :reload, 'service[consul]'
  end
end
