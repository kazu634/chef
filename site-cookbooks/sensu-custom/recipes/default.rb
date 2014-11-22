#
# Cookbook Name:: sensu-custom
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "build-essential"

include_recipe "sensu::default"

include_recipe "sensu-custom::prerequisites"
include_recipe "sensu-custom::nagios-plugins"

include_recipe "sensu-custom::client_settings"
include_recipe "sensu-custom::deploy_scripts"

if node["sensu-custom"]["server"]
  include_recipe "sensu::rabbitmq"
  include_recipe "sensu::redis"
  include_recipe "sensu::server_service"
  include_recipe "sensu::api_service"

  include_recipe "nginx"
  include_recipe "uchiwa"

  include_recipe "sensu-custom::server_settings"

  # Modify the redis configuration for it to start successfully
  # (older version of redis does not support the settings,
  #  the redis cookbook deploys.)
  script "modify the redis configuration" do
    interpreter "bash"

    user        "root"
    group       "root"

    code <<-EOH
    sed -ie "s/^notify-keyspace-events/# notify-keyspace-events/" /etc/redis/6379.conf
    EOH

    only_if "grep '^notify-' /etc/redis/6379.conf"
  end
end

include_recipe "sensu::client_service"
