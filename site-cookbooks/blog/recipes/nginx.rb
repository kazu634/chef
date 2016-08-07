#
# Cookbook Name:: blog
# Recipe:: nginx
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template '/etc/nginx/sites-available/blog' do
  source 'blog'
  owner 'root'
  group 'root'
  mode 0644

  variables fqdn: node['blog']['FQDN']
end

directory '/var/www/blog' do
  owner 'www-data'
  group 'webadm'
  mode 0770
  recursive true
end

mount '/var/www/blog' do
  pass 0
  fstype 'tmpfs'
  device 'tmpfs'
  options 'size=150m,noatime'
  action [:mount, :enable]

  notifies :create, 'directory[/var/www/blog]'
end

template '/etc/cron.d/blog' do
  source 'blog.crontab'
  owner 'root'
  group 'root'
  mode 0644

  variables fqdn: node['blog']['FQDN']
end

cookbook_file '/etc/monit/conf.d/blog-log.conf' do
  source 'blog-log.conf'

  owner 'root'
  group 'root'
  mode 0644

  notifies :reload, 'service[monit]'
end
