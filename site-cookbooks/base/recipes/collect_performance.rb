#
# Cookbook Name:: base
# Recipe:: collect_performance
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "dstat" do
  action :install
end

cookbook_file "/etc/cron.d/dstat" do
  owner "root"
  group "root"

  mode 0644
end

cookbook_file "/etc/rc.local" do
  owner "root"
  group "root"

  mode 0755
end
