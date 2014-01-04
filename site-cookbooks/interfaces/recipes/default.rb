#
# Cookbook Name:: interfaces
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "base"

if /^vm-/ =~ node['hostname'] then
  template "/etc/network/interfaces" do
    source "interfaces.erb"
    mode    0644
    owner   "root"
    group   "root"

    variables({
      :ipaddress => node['ipaddress']
    })

    notifies :restart, "service[networking]"
  end

  service "networking" do
    action :nothing
  end
end
