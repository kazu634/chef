#
# Cookbook Name:: fluentd-custom
# Recipe:: prerequisites
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'monit'

cookbook_file '/etc/security/limits.d/90-nfile.conf' do
  source '90-nfile.conf'

  owner 'root'
  group 'root'

  mode 0644
end
