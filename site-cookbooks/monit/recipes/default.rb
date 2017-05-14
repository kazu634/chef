#
# Cookbook Name:: monit
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'monit' do
  action :install
end

service 'monit' do
  action :disable
end

cookbook_file '/etc/monit/monitrc' do
  source 'monitrc'
  mode 0o600
  owner 'root'
  group 'root'

  notifies :reload, 'service[monit]'
end

case
when node['platform_version'].to_f < 16.04
  template '/etc/init/monit.conf' do
    source 'monit.conf.erb'
    mode 0o644
    owner 'root'
    group 'root'

    notifies :run, 'script[initctl reload-configuration]'
  end

  script 'initctl reload-configuration' do
    interpreter 'bash'

    user 'root'
    group 'root'

    code <<-EOH
    /etc/init.d/monit stop && update-rc.d -f monit remove
    initctl reload-configuration
    EOH

    action :nothing
  end

when node['platform_version'].to_f < 16.04
  cookbook_file '/etc/default/monit' do
    source 'monit'
    mode 0o644
    owner 'root'
    group 'root'

    notifies :run, 'script[systemctl daemon-reload]'
  end

  cookbook_file '/lib/systemd/system/monit.service' do
    source 'monit.service'
    mode 0o644
    owner 'root'
    group 'root'

    notifies :run, 'script[systemctl daemon-reload]'
  end

  script 'systemctl daemon-reload' do
    interpreter 'bash'

    user 'root'
    group 'root'

    code <<-EOH
    /etc/init.d/monit stop && systemctl daemon-reload
    systemctl enable monit && systemctl start monit
    EOH

    action :nothing
  end
end
