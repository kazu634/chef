#
# Cookbook Name:: wordpress
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "wordpress::prerequisites"

include_recipe "wordpress::mysql"

include_recipe "wordpress::php5-fpm"

include_recipe "wordpress::nginx"

include_recipe "wordpress::wordpress"

