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
