#
# Cookbook Name:: prometheus
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

if node['prometheus']['manager']
  include_recipe 'prometheus::install'
  include_recipe 'prometheus::setup'
end

include_recipe 'prometheus::node_exporter_install'
include_recipe 'prometheus::node_exporter_setup'
