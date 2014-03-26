#
# Cookbook Name:: base
# Recipe:: packages
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

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

include_recipe "base::git_config"

package "vim-nox" do
  action :install
end

package "debian-keyring" do
  action :install
end

package "screen" do
  action :install
end

%w{ ruby rubygems }.each do |p|
  package p do
    action :install
  end
end
