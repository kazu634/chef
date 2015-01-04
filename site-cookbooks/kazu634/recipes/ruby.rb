#
# Cookbook Name:: base
# Recipe:: ruby
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'ruby'

ruby_setup 'kazu634' do
  action :install
end

directory '/home/kazu634/bin' do
  owner 'kazu634'
  group 'kazu634'
  mode 0755

  action :create
end

directory '/home/kazu634/.chef' do
  owner 'kazu634'
  group 'kazu634'
  mode 0775

  action :create
end

template '/home/kazu634/.chef/knife.rb' do
  source 'knife.rb.erb'

  owner 'kazu634'
  group 'kazu634'

  mode 0644
end
