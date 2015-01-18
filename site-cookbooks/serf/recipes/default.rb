#
# Cookbook Name:: serf
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'serf::prerequisites'

include_recipe 'serf::install'

include_recipe 'serf::setup'
