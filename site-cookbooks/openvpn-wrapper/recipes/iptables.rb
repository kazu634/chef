#
# Cookbook Name:: openvpn-wrapper
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "iptables"

cookbook_file "/etc/iptables.snat" do
  source "iptables.snat"

  owner "root"
  group "root"
  mode 0444
end

iptables_rule "openvpn"
