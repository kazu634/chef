#
# Cookbook Name:: nginx
# Recipe:: respawn
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

case
when node['platform_version'].to_f < 16.04
  cookbook_file '/etc/monit/conf.d/nginx.conf' do
    source 'nginx.conf'

    user 'root'
    group 'root'
    mode 0644

    notifies :restart, 'service[monit]'
  end
when node['platform_version'].to_f >= 16.04
  cookbook_file '/lib/systemd/system/nginx.service' do
    source 'nginx.service'

    user 'root'
    group 'root'
    mode 0644
  end
end

service 'nginx' do
  action :enable
  supports restart: true, reload: true, status: true
end
