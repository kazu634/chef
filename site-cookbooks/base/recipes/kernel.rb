#
# Cookbook Name:: base
# Recipe:: kernel
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w( 90-vm-swappiness.conf 90-vfs-cache-pressure.conf ).each do |conf|
  cookbook_file "/etc/sysctl.d/#{conf}" do
    owner 'root'
    group 'root'

    mode 0644
  end
end
