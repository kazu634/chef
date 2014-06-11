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
include_recipe "base::ntp"

# only install amd64 package
# http://d.hatena.ne.jp/ritchey/20121229
case node["platform"]
when "ubuntu"
  if node["platform_version"].to_f >= 12.10
    script "sudo dpkg --remove-architecture i386" do
      interpreter "bash"

      user "root"
      group "root"

      code <<-EOH
      sudo dpkg --remove-architecture i386
      EOH

      not_if "dpkg --print-foreign-architectures | grep -v i386"
    end
  else
    cookbook_file "/etc/dpkg/dpkg.cfg.d/multiarch" do
      source   "multiarch"
      owner    "root"
      group    "root"
      mode     0644
    end
  end
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

remote_file "/etc/motd.tail" do
  source   "https://gist.githubusercontent.com/makocchi-git/9775443/raw/746887fbc6e1a7c6b120af0abcfe58701e8b4550/slime-allstar.txt"

  owner    "root"
  group    "root"

  mode     0644
end
