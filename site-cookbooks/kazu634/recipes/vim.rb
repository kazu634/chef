#
# Cookbook Name:: base
# Recipe:: vim
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

git "/home/kazu634/.vim" do
  repo "git://github.com/kazu634/vim.git"
  destination "/home/kazu634/.vim"
  revision "master"
  user "kazu634"
  group "kazu634"
  action :sync
end

directory "/home/kazu634/.vim/bundle/" do
  owner "kazu634"
  group "kazu634"
  mode 0755
  action :create
end

git "neobundle" do
  repo          "git://github.com/Shougo/neobundle.vim"
  destination   "/home/kazu634/.vim/bundle/neobundle.vim"
  user          "kazu634"
  group         "kazu634"
  action        :sync
end

