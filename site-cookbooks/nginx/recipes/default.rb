#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apt'
include_recipe 'build-essential'
include_recipe 'monit' if node['platform_version'].to_f < 16.04

include_recipe 'nginx::kernel'

include_recipe 'nginx::build'
include_recipe 'nginx::setup'

include_recipe 'nginx::respawn'

include_recipe 'nginx::letsencrypt'
