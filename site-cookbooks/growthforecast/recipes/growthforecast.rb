#
# Cookbook Name:: growthforecast
# Recipe:: growthforecast
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

script "Install GrowthForecast." do
  interpreter "bash"

  user "growth"
  group "growth"

  environment({'PERLBREW_ROOT' => "#{node['growthforecast']['home']}/perlbrew",
               'PERLBREW_HOME' => "#{node['growthforecast']['home']}/.perlbrew",
               'PERLBREW_PATH' => "#{node['growthforecast']['home']}/perl5/perlbrew/bin:/home/growth/perl5/perlbrew/perls/#{node['growthforecast']['perl']}/bin",
               'PERLBREW_PERL' => node['growthforecast']['perl'],
               'HOME'          => node['growthforecast']['home']
              })

  code <<-EOH
  source #{node['growthforecast']['home']}/perl5/perlbrew/etc/bashrc

  #{node['growthforecast']['home']}/perl5/perlbrew/bin/cpanm -n GrowthForecast
  EOH
end

directory "#{node['growthforecast']['home']}/appdata/" do
  owner   "growth"
  group   "growth"

  mode    0775
end

directory "/var/log/growthforecast" do
  owner   "growth"
  group   "growth"

  mode    0755
end

service "growthforecast" do
  supports :restart => true,   :start => true,   :stop => true
  action :nothing
end

cookbook_file "/etc/init.d/growthforecast" do
  owner   "root"
  group   "root"

  mode    0755

  notifies :enable,  "service[growthforecast]"
  notifies :start,   "service[growthforecast]"
end

template "/etc/nginx/sites-available/growth" do
  source "growth.erb"

  owner "root"
  group "root"

  mode 0644

  notifies :reload, "service[nginx]"
end

cookbook_file "/etc/nginx/.htpasswd_growth" do
  owner   "root"
  group   "root"

  mode    0644

  notifies :reload, "service[nginx]"
end

link "/etc/nginx/sites-enabled/growthforecast" do
  to "/etc/nginx/sites-available/growth"
end
