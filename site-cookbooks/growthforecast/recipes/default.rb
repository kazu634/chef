#
# Cookbook Name:: growthforecast
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "nginx"

include_recipe "growthforecast::prerequisites"

include_recipe "growthforecast::perlbrew"

include_recipe "growthforecast::growthforecast"
