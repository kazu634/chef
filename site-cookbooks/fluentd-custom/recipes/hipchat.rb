#
# Cookbook Name:: fluentd-custom
# Recipe:: hipchat
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

if node[:td_agent][:forward]
  # Install prerequisite gems
  %w{ fluent-plugin-buffered-hipchat }.each do |pkg|
    gem_package pkg do
      action :upgrade

      gem_binary '/usr/lib/fluent/ruby/bin/fluent-gem'
    end
  end
end
