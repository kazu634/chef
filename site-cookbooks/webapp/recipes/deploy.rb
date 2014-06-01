#
# Cookbook Name:: webapp
# Recipe:: deploy
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# make directory for storing Web application(s):
directory "#{node['webapp']['home']}/apps" do
  owner   "webapp"
  group   "webapp"

  mode    0755
end
