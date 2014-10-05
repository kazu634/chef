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
    gem_package pkg do
      action :upgrade

      gem_binary '/usr/lib/fluent/ruby/bin/fluent-gem'
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
