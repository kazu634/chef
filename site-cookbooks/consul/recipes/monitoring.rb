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

# Deploy `consul` monitoring config file:
%w(disk load ssh swap).each do |target|
  cookbook_file "/etc/consul.d/check-#{target}.json" do
    owner 'root'
    group 'root'
    mode 0o644

    notifies :reload, 'service[consul]'
  end
end
