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

include_recipe "sensu-custom::server_varnish"
