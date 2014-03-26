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

# timezone setting

cookbook_file "/etc/timezone" do
  source "timezone"

  owner "root"
  group "root"
  mode  0644
end

script "Timezone Settings" do
  interpreter "bash"

  user "root"
  group "root"

  code <<-EOH
  cp  /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
  EOH

  not_if "diff /usr/share/zoneinfo/Asia/Tokyo /etc/localtime"
end

directory "/etc/sudoers.d" do
  owner     "root"
  group     "root"
  mode      0755

  not_if   "test -e /etc/sudoers.d"
end

# ntpdate settings

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

