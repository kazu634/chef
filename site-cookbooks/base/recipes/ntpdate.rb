#
# Cookbook Name:: base
# Recipe:: ntpdate
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "/etc/default/ntpdate" do
  source   "ntpdate"
  owner    "root"
  group    "root"
  mode     0644
end

cookbook_file "/etc/cron.hourly/ntpdate" do
  source   "ntpdate-cron"
  owner    "root"
  group    "root"
  mode     0755
end

