#
# Cookbook Name:: peco
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Calculate the latest peco version:
peco_url = ''

begin
  require 'net/http'

  uri = URI.parse('https://github.com/peco/peco/releases/latest')

  timeout(3) do
    response = Net::HTTP.get_response(uri)

    vtag = $1 if response.body =~ %r{tag\/(v\d+\.\d+\.\d+)}

    peco_url = "#{node['peco']['url']}/#{vtag}/#{node['peco']['tarball']}"
  end
rescue
  # Abort the chef client process:
  raise 'Cannot connect to http://github.com.'
end

# Download:
archive = remote_file File.join(Chef::Config[:file_cache_path], 'peco_linux_amd64.tar.gz') do
  source peco_url
  action :create_if_missing
end

# Install:
install_dir = directory File.join(node['peco']['prefix'], 'share/peco')

execute "tar zxf #{archive.path} -C #{install_dir.path} --strip-components 1" do
  creates File.join(install_dir.path, 'peco')
end

execute 'install peco' do
  binary = File.join(node['peco']['prefix'], 'bin/peco')

  command "cp #{File.join(install_dir.path, 'peco')} #{binary} && chmod +x #{binary}"
end
