#
# Cookbook Name:: nginx
# Recipe:: setup
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w( body fastcgi proxy scgi uwsgi ).each do |d|
  directory "/var/lib/nginx/#{d}" do
    owner 'www-data'
    group 'root'
    mode 0755
    recursive true
    action :create
  end
end

%w( sites-available sites-enabled ).each do |d|
  directory "/etc/nginx/#{d}" do
    owner 'root'
    group 'root'
    mode 0755
    recursive true
    action :create
  end
end

template '/etc/nginx/nginx.conf' do
  source 'nginx.conf.erb'
  owner 'root'
  group 'root'
  mode 0644
  action :create
end

%w( default maintenance ).each do |conf|
  template "/etc/nginx/sites-available/#{conf}" do
    source "#{conf}.erb"
    owner 'root'
    group 'root'
    mode 0644
    action :create
  end
end

link '/etc/nginx/sites-enabled/maintenance' do
  to '/etc/nginx/sites-available/maintenance'
  owner 'root'
  group 'root'
  mode 0644

  notifies :restart, 'service[nginx]'

  not_if { File.exist?('/etc/nginx/sites-enabled/maintenance') || File.exist?('/etc/nginx/sites-enabled/default') }
end

cookbook_file '/etc/monit/conf.d/nginx.conf' do
  source 'nginx.conf'

  user 'root'
  group 'root'
  mode 0644

  notifies :restart, 'service[monit]'
end

service 'nginx' do
  action :nothing
  supports restart: true, reload: true, status: true
end

cookbook_file '/etc/logrotate.d/nginx' do
  source 'nginx.logrotate'
  owner 'root'
  group 'root'
  mode 0644
  action :create
end

# for iptables:
include_recipe 'iptables'
iptables_rule 'nginx'
