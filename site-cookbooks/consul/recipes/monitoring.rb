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

  notifies :run, 'bash[Reload supervisor]'
end

# Deploy the check_memory script:
package 'bc' do
  action :install
end

remote_file '/usr/lib/nagios/plugins/check_memory' do
  source 'https://raw.githubusercontent.com/zwindler/check_mem_ng/master/check_mem_ng.sh'

  owner 'root'
  group 'root'
  mode 0o555
end

# Deploy `consul` monitoring config file:
%w(disk load ssh swap reboot-required memory).each do |target|
  cookbook_file "/etc/consul.d/check-#{target}.json" do
    owner 'root'
    group 'root'

    mode 0o644

    notifies :run, 'bash[Reload supervisor]'
  end
end
