#
# Cookbook Name:: varnish-custom
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'varnish::apt_repo'

include_recipe 'varnish::default'

template "#{node['varnish']['dir']}/#{node['varnish']['vcl_conf']}" do
  source       node['varnish']['vcl_source']

  owner        "root"
  group        "root"
  mode         0644

  notifies     :restart, "service[varnish]", :delayed
end

service "varnish" do
  action :nothing
end


include_recipe 'iptables'

iptables_rule 'varnish'
