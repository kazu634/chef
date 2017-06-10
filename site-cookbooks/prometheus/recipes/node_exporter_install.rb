#
# Cookbook Name:: prometheus
# Recipe:: node_exporter_install
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

node_exporter_url = ''
node_exporter_bin = ''

# Calculate the Download URL:
begin
  require 'net/http'

  uri = URI.parse('https://github.com/prometheus/node_exporter/releases/latest')

  timeout(3) do
    response = Net::HTTP.get_response(uri)

    vtag = $1 if response.body =~ %r{tag\/(v\d+\.\d+\.\d+)}
    tag = vtag.sub(/^v/, '')

    node_exporter_bin = "#{node['node_exporter']['prefix']}#{tag}#{node['node_exporter']['postfix']}"
    node_exporter_url = "#{node['node_exporter']['url']}/#{vtag}/#{node_exporter_bin}"
  end
rescue
  # Abort the chef client process:
  raise 'Cannot connect to http://github.com.'
end

# Download:
archive = remote_file File.join(Chef::Config[:file_cache_path], 'node_exporter.tar.gz') do
  source node_exporter_url
  action :create_if_missing
end

# Install:
node_exporter_location = File.join(node['node_exporter']['location'], 'node_exporter')

execute "tar zxf #{archive.path} -C #{node['node_exporter']['location']} --strip-components 1" do
  creates node_exporter_location
end

# Change Owner and Permissions:
file node_exporter_location do
  mode  '0755'
  owner 'root'
  group 'root'
end
