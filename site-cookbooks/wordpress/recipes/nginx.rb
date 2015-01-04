#
# Cookbook Name:: wordpress
# Recipe:: nginx
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

cookbook_file '/etc/nginx/conf.d/wordpress_proxy.conf' do
  source 'wordpress_proxy.conf'

  owner 'root'
  group 'root'
  mode 0644

  notifies :reload, 'service[nginx]'
end

template '/etc/nginx/sites-available/wordpress' do
  source 'wordpress.erb'

  owner 'root'
  group 'root'
  mode 0644

  notifies :reload, 'service[nginx]'
end

link '/etc/nginx/sites-enabled/wordpress' do
  to '/etc/nginx/sites-available/wordpress'
end
