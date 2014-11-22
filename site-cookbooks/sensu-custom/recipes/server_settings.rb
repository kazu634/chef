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

# Configure iptables settings, when in production:
if node['sensu-custom']['iptables']
  include_recipe "iptables"

  iptables_rule  "rabbitmq"
end

%w{redis.conf rabbitmq.conf sensu-server.conf sensu-api.conf uchiwa.conf}.each do |conf|
  cookbook_file "/etc/monit/conf.d/#{conf}" do
    source conf

    owner "root"
    group "root"
    mode 0644

    notifies :restart, "service[monit]"
  end
end

template "/etc/nginx/sites-available/sensu" do
  source   "sensu.erb"

  user     "root"
  group    "root"
  mode     0644

  notifies :restart, "service[nginx]"
end

link "/etc/nginx/sites-enabled/sensu" do
  to "/etc/nginx/sites-available/sensu"

  not_if "test -e /etc/nginx/sites-enabled/sensu"
end

service "nginx" do
  action :nothing
end
