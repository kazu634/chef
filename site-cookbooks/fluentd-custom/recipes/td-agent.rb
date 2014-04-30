#
# Cookbook Name:: fluentd-custom
# Recipe:: td-agent
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "chef-td-agent"

directory "/etc/td-agent/conf.d" do
  owner "root"
  group "root"

  mode  0755
end
