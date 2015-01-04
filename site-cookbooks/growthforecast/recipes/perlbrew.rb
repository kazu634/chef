#
# Cookbook Name:: growthforecast
# Recipe:: perlbrew
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

unless FileTest.exists?("#{node['growthforecast']['home']}/perl5/perlbrew/bin/perlbrew")
  remote_file "#{Chef::Config['file_cache_path']}/perlbrew.sh" do
    source 'http://install.perlbrew.pl'

    owner 'growth'
    group 'growth'

    mode 0644
  end

  script 'Install perlbrew.' do
    interpreter 'bash'

    user 'root'
    group 'root'

    code <<-EOH
    su - growth -c "bash #{Chef::Config['file_cache_path']}/perlbrew.sh"
    EOH
  end

  cookbook_file "#{node['growthforecast']['home']}/.bashrc" do
    owner 'growth'
    group 'growth'

    mode 0644
  end
end

script 'Install Perl.' do
  interpreter 'bash'

  user 'growth'
  group 'growth'

  environment('PERLBREW_ROOT' => "#{node['growthforecast']['home']}/perl5/perlbrew",
              'PERLBREW_HOME' => "#{node['growthforecast']['home']}/.perlbrew"
              )

  code <<-EOH
  source #{node['growthforecast']['home']}/perl5/perlbrew/etc/bashrc

  perlbrew install --notest #{node['growthforecast']['perl']}
  perlbrew switch #{node['growthforecast']['perl']}
  EOH

  not_if "test -e #{node['growthforecast']['home']}/perl5/perlbrew/perls/#{node['growthforecast']['perl']}/"
end

script 'Install cpanm.' do
  interpreter 'bash'

  user 'growth'
  group 'growth'

  environment('PERLBREW_ROOT' => "#{node['growthforecast']['home']}/perl5/perlbrew",
              'PERLBREW_HOME' => "#{node['growthforecast']['home']}/.perlbrew"
              )

  code <<-EOH
  source #{node['growthforecast']['home']}/perl5/perlbrew/etc/bashrc

  perlbrew install-cpanm
  EOH

  not_if "test -e #{node['growthforecast']['home']}/perl5/perlbrew/bin/cpanm"
end
