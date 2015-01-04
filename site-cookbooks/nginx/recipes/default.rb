#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apt'
include_recipe 'monit'

Encoding.default_external = Encoding::UTF_8

apt_repository 'nginx' do
  uri 'http://ppa.launchpad.net/nginx/stable/ubuntu'
  distribution node['lsb']['codename']
  components ['main']
  keyserver 'keyserver.ubuntu.com'
  key 'C300EE8C'
end

package 'nginx' do
  action :install
end

template '/etc/nginx/nginx.conf' do
  source 'nginx.conf.erb'

  owner 'root'
  group 'root'
  mode 0644

  notifies :restart, 'service[nginx]'
end

template '/etc/nginx/sites-available/default' do
  action :create
  source 'default.erb'

  mode 0644

  notifies :restart, 'service[nginx]'
end

template '/usr/share/nginx/html/index.html' do
  source 'index.html.erb'
  mode 0644
end

service 'nginx' do
  action [:enable, :start]
end

cookbook_file '/etc/monit/conf.d/nginx.conf' do
  source 'nginx.conf'

  user 'root'
  group 'root'
  mode 0644

  notifies :restart, 'service[monit]'
end

# Configure `iptables` configuration, unless in testing.
if node['nginx']['iptables']
  include_recipe 'iptables'
  iptables_rule 'nginx'
end
