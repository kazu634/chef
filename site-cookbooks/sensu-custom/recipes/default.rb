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
  include_recipe "sensu::dashboard_service"

  include_recipe "sensu-custom::server_settings"
end

include_recipe "sensu::client_service"
