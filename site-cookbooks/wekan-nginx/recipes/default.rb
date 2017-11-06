#
# Cookbook Name:: wekan-nginx
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'nginx'
include_recipe 'monit'

include_recipe 'wekan-nginx::ssl'
include_recipe 'wekan-nginx::nginx'
