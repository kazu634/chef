#
# Cookbook Name:: openvpn-wrapper
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "/etc/sysctl.conf" do
  source "sysctl.conf"

  owner "root"
  group "root"
  mode  0644
end

bash "sysctl -p" do
  code "sysctl -p"

  user "root"
  group "root"

  not_if "sysctl -a | grep 'net.ipv4.ip_forward = 1'"
end
