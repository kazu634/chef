#
# Cookbook Name:: fluentd-custom
# Recipe:: nginx
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Install prerequisite gems
%w{ fluent-plugin-rewrite-tag-filter
    fluent-plugin-amplifier-filter
    fluent-plugin-growthforecast
    fluent-plugin-forest
    fluent-plugin-numeric-counter
    fluent-plugin-datacounter
    fluent-plugin-flowcounter
  }.each do |pkg|
    td_agent_gem pkg do
      action :upgrade
    end
end

# deploy the configuration file for monitoring nginx logs
cookbook_file "/etc/td-agent/conf.d/forwarder_nginx.conf" do
  source "forwarder_nginx.conf"

  owner "root"
  group "root"

  mode 0644

  notifies :restart, "service[td-agent]"
end

# deploy the configuration file for processing nginx logs
cookbook_file "/etc/td-agent/conf.d/processor_nginx.conf" do
  source "processor_nginx.conf"

  owner "root"
  group "root"

  mode 0644

  # if the node is the fluentd manager:
  only_if { node['td_agent']['forward'] }

  notifies :restart, "service[td-agent]"
end
