#
# Cookbook Name:: sensu-custom
# Recipe:: server_settings
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'sensu-custom::server_checks'

include_recipe 'sensu-custom::server_mutators'

include_recipe 'sensu-custom::server_handlers'

# iptables setting:
include_recipe 'iptables'

iptables_rule 'redis'
iptables_rule 'rabbitmq'
iptables_rule 'sensu-iptables'

%w(redis.conf rabbitmq.conf sensu-server.conf sensu-api.conf uchiwa.conf).each do |conf|
  cookbook_file "/etc/monit/conf.d/#{conf}" do
    source conf

    owner 'root'
    group 'root'
    mode 0644

    notifies :restart, 'service[monit]'
  end
end

template '/etc/nginx/sites-available/sensu' do
  source 'sensu.erb'

  user 'root'
  group 'root'
  mode 0644

  notifies :restart, 'service[nginx]'
end

bash 'Delete the nginx maintenance file' do
  user 'root'
  group 'root'

  code <<-EOH
  rm /etc/nginx/sites-enabled/maintenance
  EOH

  only_if { File.exists?('/etc/nginx/sites-enabled/maintenance') }
end

%w( sensu default ).each do |conf|
  link "/etc/nginx/sites-enabled/#{conf}" do
    to "/etc/nginx/sites-available/#{conf}"

    not_if "test -e /etc/nginx/sites-enabled/#{conf}"
  end
end

service 'nginx' do
  action :nothing
end
