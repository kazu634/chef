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
               'PERLBREW_PERL' => "#{node['growthforecast']['perl']}",
               'HOME'          => "#{node['growthforecast']['home']}"
              })

  code <<-EOH
  source #{node['growthforecast']['home']}/perl5/perlbrew/etc/bashrc

  #{node['growthforecast']['home']}/perl5/perlbrew/bin/cpanm -n GrowthForecast
  EOH
end
