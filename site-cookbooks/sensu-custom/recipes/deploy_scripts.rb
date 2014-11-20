#
# Cookbook Name:: sensu-custom
# Recipe:: deploy_scripts
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

remote_file "/etc/sensu/plugins/check-procs.rb" do
  source "https://raw.github.com/sensu/sensu-community-plugins/master/plugins/processes/check-procs.rb"

  user   "sensu"
  group  "sensu"
  mode   0755
end

remote_file "/etc/sensu/plugins/check-log.rb" do
  source "https://raw.github.com/sensu/sensu-community-plugins/master/plugins/logging/check-log.rb"

  user   "sensu"
  group  "sensu"
  mode   0755
end

remote_file "/etc/sensu/plugins/check-load.rb" do
  source "https://raw.github.com/sensu/sensu-community-plugins/master/plugins/system/check-load.rb"

  user   "sensu"
  group  "sensu"
  mode   0755
end

remote_file "/etc/sensu/plugins/check-swap.sh" do
  source "https://raw.github.com/sensu/sensu-community-plugins/master/plugins/system/check-swap.sh"

  user   "sensu"
  group  "sensu"
  mode   0755
end

remote_file "/etc/sensu/plugins/check-disk.rb" do
  source "https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/plugins/system/check-disk.rb"
  user   "sensu"
  group  "sensu"
  mode   0755
end

cookbook_file "/etc/sensu/handlers/tw.rb" do
  source "tw.rb"

  owner  "sensu"
  group  "sensu"
  mode   0755
end

remote_file "/etc/sensu/handlers/hipchat.rb" do
  source "https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/handlers/notification/hipchat.rb"

  user   "sensu"
  group  "sensu"
  mode   0755
end
