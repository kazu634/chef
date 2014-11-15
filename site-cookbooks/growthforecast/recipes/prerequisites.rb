#
# Cookbook Name:: growthforecast
# Recipe:: prerequisites
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "build-essential"
include_recipe "nginx"

script "apt-get build-dep rrdtool" do
  interpreter "bash"

  user "root"
  group "root"

  code <<-EOH
  apt-get -y build-dep rrdtool || true
  EOH
end

package "fonts-ipafont" do
  action :install
end

user "growth" do
  comment  "User for GrowthForecast"

  home     node['growthforecast']['home']
  shell    "/bin/bash"

  supports :manage_home => true

  system   true
end
