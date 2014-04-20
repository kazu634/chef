#
# Cookbook Name:: growthforecast
# Recipe:: perlbrew
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

if not FileTest.exists?("#{node['growthforecast']['home']}/perl5/perlbrew/bin/perlbrew")
  remote_file "#{Chef::Config['file_cache_path']}/perlbrew.sh" do
    source   "http://install.perlbrew.pl"

    owner    "growth"
    group    "growth"

    mode     0644
  end

  script "Install perlbrew." do
    interpreter "bash"

    user "root"
    group "root"

    code <<-EOH
    su - growth -c "bash #{Chef::Config['file_cache_path']}/perlbrew.sh"
    EOH
  end

  cookbook_file "#{node['growthforecast']['home']}/.bashrc" do
    owner   "growth"
    group   "growth"

    mode    0644
  end
end
