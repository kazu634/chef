#
# Cookbook Name:: base
# Recipe:: ssh
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'iptables'

# Change ssh port, if the environment is production:
if node['base']['ssh']
  # Open 10022 port:
  iptables_rule 'base_10022'

  # Change `sshd_config` to use 10022:
  template '/etc/ssh/sshd_config' do
    source 'sshd_config.erb'

    owner 'root'
    group 'root'
    mode 0644

    notifies :restart, 'service[ssh]'
  end
else
  # Open 22 port, if the environment is testing:
  iptables_rule 'base_22'
end

service 'ssh' do
  case node['platform']
  when 'ubuntu'
    if node['platform_version'].to_f >= 13.10
      provider Chef::Provider::Service::Upstart
    end
  end

  action :nothing
end
