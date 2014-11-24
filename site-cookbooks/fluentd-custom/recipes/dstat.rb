#
# Cookbook Name:: fluentd-custom
# Recipe:: dstat
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Install prerequisite gems
%w{ fluent-plugin-map
    fluent-plugin-dstat
    fluent-plugin-record-reformer
    fluent-plugin-rewrite-tag-filter
    fluent-plugin-forest
    fluent-plugin-growthforecast
  }.each do |pkg|
    td_agent_gem pkg do
      action :upgrade
    end
end

# deploy the configuration file for forwarding the dstat data from the hosts
cookbook_file "/etc/td-agent/conf.d/forwarder_dstat.conf" do
  source "forwarder_dstat.conf"

  owner "root"
  group "root"

  mode 0644

  notifies :restart,  "service[td-agent]"
end

# deploy the configuration file for processing the dstat data from the hosts
cookbook_file "/etc/td-agent/conf.d/processor_dstat.conf" do
  source "processor_dstat.conf"

  owner "root"
  group "root"

  mode 0644

  # if the node is the fluentd manager:
  only_if { node['td_agent']['forward'] }

  notifies :restart,  "service[td-agent]"
end
