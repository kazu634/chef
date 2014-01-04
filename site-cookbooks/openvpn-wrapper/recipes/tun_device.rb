#
# Cookbook Name:: openvpn-wrapper
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "udev" do
  action :install
end

bash "create /dev/net/tun" do
  user "root"
  group "root"

  code <<-EOH
  mkdir /dev/net
  mknod /dev/net/tun c 10 200
  chmod 0700 /dev/net/tun
  EOH

  not_if "test -e /dev/net/tun"
end
