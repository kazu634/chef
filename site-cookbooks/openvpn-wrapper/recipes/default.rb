#
# Cookbook Name:: openvpn-wrapper
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "openvpn-wrapper::iptables"
include_recipe "openvpn-wrapper::kernel_param"
include_recipe "openvpn-wrapper::tun_device"

include_recipe "openvpn::default"
include_recipe "openvpn::users"

include_recipe "openvpn-wrapper::router"
