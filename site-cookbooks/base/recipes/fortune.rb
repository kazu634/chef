#
# Cookbook Name:: base
# Recipe:: fortune
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'fortune' do
  action :install
end

remote_file "#{Chef::Config[:file_cache_path]}/starwars.tgz" do
  source 'http://www.splitbrain.org/_media/projects/fortunes/fortune-starwars.tgz'

  owner 'root'
  group 'root'
  mode 0644

  not_if 'test -e /usr/share/games/fortunes/starwars.dat'
end

script 'Install starwars fortune data' do
  interpreter 'bash'

  user 'root'
  group 'root'

  cwd "#{Chef::Config[:file_cache_path]}/"

  code <<-EOH
    tar xf starwars.tgz

    cd fortune-starwars/
    cp starwars.dat /usr/share/games/fortunes/
    cp starwars /usr/share/games/fortunes/
  EOH

  not_if 'test -e /usr/share/games/fortunes/starwars.dat'
end
