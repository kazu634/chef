#
# Cookbook Name:: wordpress
# Recipe:: prerequisites
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'nginx'

# prerequisite package installation:
pre_requisites = %w(php5-common php5-cgi php5-cli php5-mysql php5-gd php5-fpm mysql-server)

pre_requisites.each do |p|
  package p do
    action :install

    response_file 'mysql.seed'
  end
end
