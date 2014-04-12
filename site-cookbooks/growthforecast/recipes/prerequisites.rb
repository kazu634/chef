#
# Cookbook Name:: growthforecast
# Recipe:: prerequisites
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

script "apt-get build-dep rrdtool" do
  interpreter "bash"

  user "root"
  group "root"

  code <<-EOH
  apt-get -y build-dep rrdtool
  EOH
end
