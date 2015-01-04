#
# Cookbook Name:: sensu-custom
# Recipe:: nagios-plugins
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'nagios-plugins' do
  action :install

  options '--no-install-recommends'
end
