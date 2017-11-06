#
# Cookbook Name:: nginx
# Recipe:: letsencrypt
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'nginx::webadm'

package 'git' do
  action :install
end

git '/home/webadm/letsencrypt' do
  repository 'https://github.com/certbot/certbot'
  action :sync
  user 'webadm'
  group 'webadm'
end
