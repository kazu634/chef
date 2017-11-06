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

directory '/home/webadm/bin' do
  owner 'webadm'
  group 'webadm'
  mode 0755
end

template '/home/webadm/bin/ssl_renewal.sh' do
  source 'ssl_renewal.sh'
  owner 'webadm'
  group 'webadm'
  mode 0755
end

template '/etc/cron.d/ssl' do
  source 'ssl.crontab'
  owner 'root'
  group 'root'
  mode 0644
end
