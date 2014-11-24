#
# Cookbook Name:: fluentd-custom
# Recipe:: aptitude
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Install prerequisite gems
%w{ fluent-plugin-rewrite-tag-filter
    fluent-plugin-grep
  }.each do |pkg|
    td_agent_gem pkg do
      action :upgrade
  end
end

# deploy the configuration file for monitoring /var/log/apt/history.log
cookbook_file "/etc/td-agent/conf.d/forwarder_aptitude.conf" do
  source "forwarder_aptitude.conf"

  owner "root"
  group "root"

  mode 0644

  notifies :restart,  "service[td-agent]"
end

# deploy the configuration file for processing /var/log/apt/history.log
cookbook_file "/etc/td-agent/conf.d/processor_aptitude.conf" do
  source "processor_aptitude.conf"

  owner "root"
  group "root"

  mode 0644

  # if the node is the fluentd manager:
  only_if { node['td_agent']['forward'] }

  notifies :restart,  "service[td-agent]"
end

