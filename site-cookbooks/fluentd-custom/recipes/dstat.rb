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
    gem_package pkg do
      action :upgrade

      gem_binary '/usr/lib/fluent/ruby/bin/fluent-gem'
    end
end
