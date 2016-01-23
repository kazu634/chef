#
# Cookbook Name:: nginx
# Recipe:: kernel
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# kernel parameters:
%w( 90-nginx.conf ).each do |conf|
  cookbook_file "/etc/sysctl.d/#{conf}" do
    owner 'root'
    group 'root'

    mode 0644
  end
end
