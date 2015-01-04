#
# Cookbook Name:: wordpress
# Recipe:: php5-fpm
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template '/etc/php5/fpm/pool.d/www.conf' do
  source 'www.conf.erb'

  owner 'root'
  group 'root'
  mode 0644

  notifies :restart, 'service[php5-fpm]'
end

service 'php5-fpm' do
  case node['platform']
  when 'ubuntu'
    if node['platform_version'].to_f >= 13.10
      provider Chef::Provider::Service::Upstart
    end
  end

  action :nothing
end
