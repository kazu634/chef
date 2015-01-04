#
# Cookbook Name:: peco
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

archive = remote_file File.join(Chef::Config[:file_cache_path], 'peco_linux_amd64.tar.gz') do
  source node['peco']['url']
  action :create_if_missing
end

install_dir = directory File.join(node['peco']['prefix'], 'share/peco')

execute "tar zxf #{archive.path} -C #{install_dir.path} --strip-components 1" do
  creates File.join(install_dir.path, 'peco')
end

execute 'install peco' do
  binary = File.join(node['peco']['prefix'], 'bin/peco')

  command "cp #{File.join(install_dir.path, 'peco')} #{binary} && chmod +x #{binary}"

  not_if { File.exist?(binary) }
end
