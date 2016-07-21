#
# Cookbook Name:: base
# Recipe:: unnecessary
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w( apparmor iscsid lxc lxcfs lxd-containers lxd open-iscsi ).each do |s|
  service s do
    ignore_failure true
    action [:disable,  :stop]

    only_if node['platform_version'].to_f == 16.04
  end
end
