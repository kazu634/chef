#
# Cookbook Name:: openvpn-wrapper
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

bash "Add default gateway configuration" do
  user "root"
  group "root"

  code <<-EOH
  echo 'push "redirect-gateway def1 bypass-dhcp"' >> /etc/openvpn/server.conf
  EOH

  not_if "grep 'push \"redirect-gateway def1 bypass-dhcp\"' server.conf"
end
