#
# Cookbook Name:: consul-template
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'consul::default'
include_recipe 'consul-template::install'

include_recipe 'consul-template::setup'
