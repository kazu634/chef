#
# Cookbook Name:: base
# Recipe:: git_config
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

remote_file '/usr/share/git-core/templates/hooks/pre-push' do
  source 'https://gist.github.com/kazu634/8267388/raw/e9202cd4c29a66723c88d2be05f3cd19413d2137/pre-push'

  owner 'root'
  group 'root'
  mode 0755

  not_if 'test -e /usr/share/git-core/templates/hooks/pre-push'
end

cookbook_file '/usr/share/git-core/templates/hooks/pre-commit' do
  action :create

  owner 'root'
  group 'root'
  mode 0755

  source 'pre-commit'
end

cookbook_file '/usr/share/git-core/templates/hooks/prepare-commit-msg' do
  action :create

  owner 'root'
  group 'root'
  mode 0755

  source 'prepare-commit-msg'
end
