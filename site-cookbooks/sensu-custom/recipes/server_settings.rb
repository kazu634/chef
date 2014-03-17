#
# Cookbook Name:: sensu-custom
# Recipe:: server_settings
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "sensu-custom::server_checks"

include_recipe "sensu-custom::server_handlers"

include_recipe "iptables"
iptables_rule  "rabbitmq"

%w{redis.conf rabbitmq.conf}.each do |conf|
  cookbook_file "/etc/monit/conf.d/#{conf}" do
    source "#{conf}"

    owner "root"
    group "root"
    mode 0644

    notifies :restart, "service[monit]"
  end
end

include_recipe "sensu-custom::server_varnish"
