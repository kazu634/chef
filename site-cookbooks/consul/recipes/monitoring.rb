#
# Cookbook Name:: consul
# Recipe:: monitoring
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Install `nagios-plugins`:
package 'nagios-plugins' do
  action :install

  options '--no-install-recommends'
end
