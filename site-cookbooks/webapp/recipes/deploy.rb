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

# deploy the apps:
git "#{node['webapp']['home']}/apps/gcal2dailyplanner" do
  repository "https://github.com/kazu634/gcal2dailyplanner.git"
  revision "master"
  action :sync

  user "webapp"
  group "webapp"

  not_if "test -e #{node['webapp']['home']}/apps/gcal2dailyplanner"
end

# nginx configuration
cookbook_file "/etc/nginx/sites-available/gcal" do
  owner "root"
  group "root"

  mode 0644

  notifies :reload, "service[nginx]"
end

link "/etc/nginx/sites-enabled/gcal" do
  to "/etc/nginx/sites-available/gcal"
end

# /etc/init.d/ scripts
service "webapp_calendar" do
  supports :restart => true,   :start => true,   :stop => true
  action :nothing
end

cookbook_file "/etc/init.d/webapp_calendar" do
  owner   "root"
  group   "root"

  mode    0755

  notifies :enable,  "service[webapp_calendar]"
end
