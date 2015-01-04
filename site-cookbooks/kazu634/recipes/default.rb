#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apt'
include_recipe 'build-essential'
include_recipe 'base'

include_recipe 'kazu634::kazu634'
include_recipe 'kazu634::ssh'
include_recipe 'kazu634::vim'

# ruby support
if node['kazu634']['ruby_support']
  include_recipe 'kazu634::ruby'
  include_recipe 'kazu634::repo'
end
