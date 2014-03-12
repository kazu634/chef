#
# Cookbook Name:: sensu-custom
# Recipe:: prerequisites
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{ sensu-plugin twitter }.each do |p|
  gem_package p do
    action     :install
    retries    3
    gem_binary("/opt/sensu/embedded/bin/gem")
  end
end
