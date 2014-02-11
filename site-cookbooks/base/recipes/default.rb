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
include_recipe "iptables"

include_recipe "base::cron-apt"

# only install amd64 package
cookbook_file "/etc/dpkg/dpkg.cfg.d/multiarch" do
  source   "multiarch"
  owner    "root"
  group    "root"
  mode     0644
end

iptables_rule "base_10022"

template "/etc/ssh/sshd_config" do
  source   "sshd_config.erb"

  owner    "root"
  group    "root"
  mode     0644

  notifies :restart, "service[ssh]"
end

service "ssh" do
    action :nothing
end

# fortune
package "fortune" do
  action :install
end

remote_file "#{Chef::Config[:file_cache_path]}/starwars.tgz" do
  source "http://www.splitbrain.org/_media/projects/fortunes/fortune-starwars.tgz"

  owner "root"
  group "root"
  mode 0644

  not_if "test -e /usr/share/games/fortunes/starwars.dat"
end

script "Install starwars fortune data" do
  interpreter "bash"

  user "root"
  group "root"

  cwd "#{Chef::Config[:file_cache_path]}/"

  code <<-EOH
    tar xf starwars.tgz

    cd fortune-starwars/
    cp starwars.dat /usr/share/games/fortunes/
    cp starwars /usr/share/games/fortunes/
  EOH

  not_if "test -e /usr/share/games/fortunes/starwars.dat"
end

package "zsh" do
  action :install

  not_if "which zsh"
end

apt_repository "git" do
  uri            "http://ppa.launchpad.net/git-core/ppa/ubuntu"
  distribution   node['lsb']['codename']
  components     ['main']
  keyserver 'keyserver.ubuntu.com'
  key 'E1DF1F24'
end

package "git-core" do
  action :install

  options "--force-yes"
end

remote_file "/usr/share/git-core/templates/hooks/pre-push" do
  source "https://gist.github.com/kazu634/8267388/raw/e9202cd4c29a66723c88d2be05f3cd19413d2137/pre-push"

  owner "root"
  group "root"
  mode 0755

  not_if "test -e /usr/share/git-core/templates/hooks/pre-push"
end

cookbook_file "/usr/share/git-core/templates/hooks/pre-commit" do
  action   :create

  owner    "root"
  group    "root"
  mode     0755

  source   "pre-commit"
end

cookbook_file "/usr/share/git-core/templates/hooks/prepare-commit-msg" do
  action   :create

  owner    "root"
  group    "root"
  mode     0755

  source   "prepare-commit-msg"
end

cookbook_file "/usr/local/bin/git-ticket" do
  action   :create

  owner    "root"
  group    "root"
  mode     0755
end

package "vim-nox" do
  action :install
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

# debian keyrings

package "debian-keyring" do
  action :install
end

# screen

package "screen" do
  action :install
end

# ruby

%w{ ruby rubygems }.each do |p|
  package p do
    action :install
  end
end
