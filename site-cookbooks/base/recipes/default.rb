#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apt"
include_recipe "build-essential"

include_recipe "base::cron-apt"
include_recipe "base::ssh"
include_recipe "base::fortune"
include_recipe "base::packages"
include_recipe "base::timezone"
include_recipe "base::ntpdate"

# only install amd64 package
cookbook_file "/etc/dpkg/dpkg.cfg.d/multiarch" do
  source   "multiarch"
  owner    "root"
  group    "root"
  mode     0644
end

script "Language Settings" do
  interpreter "bash"

  user "root"
  group "root"

  code <<-EOH
  locale-gen ja_JP.UTF-8
  dpkg-reconfigure locales
  update-locale LANG=ja_JP.UTF-8
  EOH
end

directory "/etc/sudoers.d" do
  owner     "root"
  group     "root"
  mode      0755

  not_if   "test -e /etc/sudoers.d"
end
