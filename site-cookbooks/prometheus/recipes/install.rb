#
# Cookbook Name:: prometheus
# Recipe:: install
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

prometheus_url = ''
prometheus_bin = ''

# Calculate the Download URL:
begin
  require 'net/http'

  uri = URI.parse('https://github.com/prometheus/prometheus/releases/latest')

  timeout(3) do
    response = Net::HTTP.get_response(uri)

    vtag = $1 if response.body =~ %r{tag\/(v\d+\.\d+\.\d+)}
    tag = vtag.sub(/^v/, '')

    prometheus_bin = "#{node['prometheus']['prefix']}#{tag}#{node['prometheus']['postfix']}"
    prometheus_url = "#{node['prometheus']['url']}/#{vtag}/#{prometheus_bin}"
  end
rescue
  # Abort the chef client process:
  raise 'Cannot connect to http://github.com.'
end

# Download:
archive = remote_file File.join(Chef::Config[:file_cache_path], 'prometheus.tar.gz') do
  source prometheus_url
  action :create_if_missing
end

# Install:
prometheus_location = File.join(node['prometheus']['location'], 'prometheus')

execute "tar zxf #{archive.path} -C #{node['prometheus']['location']} --strip-components 1" do
  creates prometheus_location
end

# Change Owner and Permissions:
file prometheus_location do
  mode  '0755'
  owner 'root'
  group 'root'
end
