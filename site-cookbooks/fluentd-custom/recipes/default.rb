#
# Cookbook Name:: fluentd-custom
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "fluentd-custom::prerequisites"

include_recipe "fluentd-custom::td-agent"

include_recipe "fluentd-custom::dstat"
