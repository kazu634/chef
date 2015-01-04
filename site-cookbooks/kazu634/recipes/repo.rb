#
## Cookbook Name:: base
## Recipe:: default
##
## Copyright 2013,  YOUR_COMPANY_NAME
##
## All rights reserved - Do Not Redistribute
##

git '/home/kazu634/repo/chef' do
  repo 'git://github.com/kazu634/chef.git'

  user 'kazu634'
  group 'kazu634'

  action :sync
end
