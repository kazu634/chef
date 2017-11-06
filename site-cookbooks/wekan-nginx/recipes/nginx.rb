#
# Cookbook Name:: wekan-nginx
# Recipe:: nginx
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template '/etc/nginx/sites-available/wekan-nginx' do
  source 'wekan-nginx'
  owner 'root'
  group 'root'
  mode 0644

  variables fqdn: node['wekan-nginx']['FQDN']
end

link '/etc/nginx/sites-enabled/wekan-nginx' do
  to '/etc/nginx/sites-available/wekan-nginx'
  notifies :restart, 'service[nginx]'
end
