#
# Cookbook Name:: blog
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'nginx'
include_recipe 'monit'

include_recipe 'blog::ssl'
include_recipe 'blog::nginx'
