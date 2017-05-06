#
# Cookbook Name:: fluentd-custom
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'fluentd-custom::prerequisites'

include_recipe 'fluentd-custom::td_agent'
include_recipe 'fluentd-custom::processor'

include_recipe 'fluentd-custom::aptitude'
include_recipe 'fluentd-custom::auth'
include_recipe 'fluentd-custom::consul'
include_recipe 'fluentd-custom::cron-apt'
include_recipe 'fluentd-custom::dpkg'
include_recipe 'fluentd-custom::monit'
include_recipe 'fluentd-custom::nginx'
include_recipe 'fluentd-custom::slack'
