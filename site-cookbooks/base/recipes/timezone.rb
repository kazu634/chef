#
# Cookbook Name:: base
# Recipe:: timezone
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "/etc/timezone" do
  source "timezone"

  owner "root"
  group "root"
  mode  0644
end

script "Timezone Settings" do
  interpreter "bash"

  user "root"
  group "root"

  code <<-EOH
  cp  /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
  EOH

  not_if "diff /usr/share/zoneinfo/Asia/Tokyo /etc/localtime"
end
