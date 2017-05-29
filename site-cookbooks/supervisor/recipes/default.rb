#
# Cookbook Name:: supervisor
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'supervisor' do
  action :install
end

service 'supervisor' do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end
