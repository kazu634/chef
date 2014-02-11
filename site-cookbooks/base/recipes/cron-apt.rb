#
# Cookbook Name:: base
# Recipe:: cron-apt
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "cron-apt" do
  action :install
end

cookbook_file "/etc/cron-apt/config" do
  source "config"

  owner "root"
  group "root"
  mode 0644
end

cookbook_file "/etc/cron-apt/action.d/3-download" do
  source "3-download"

  owner "root"
  group "root"
  mode 0644
end

script "Generate /etc/apt/security.sources.list" do
  interpreter "bash"

  user "root"
  group "root"

  code <<-EOH
    grep security /etc/apt/sources.list > /etc/apt/security.sources.list
  EOH

  not_if "test -s /etc/apt/security.sources.list"
end
