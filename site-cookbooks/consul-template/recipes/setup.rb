#
# Cookbook Name:: consul-template
# Recipe:: setup
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# `consul-template`-related paths:
%w(/etc/consul-template.d).each do |d|
  directory d do
    owner 'root'
    group 'root'

    mode 0o755

    recursive true
    action :create
  end
end
