#
# Cookbook Name:: consul
# Recipe:: install
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# -------------------------------------------
# Calculating the latest `consul` version:
# -------------------------------------------
download_url = ''

begin
  require 'net/http'

  uri = URI.parse('https://www.consul.io/downloads.html')

  timeout(3) do
    response = Net::HTTP.get_response(uri)

    if response.body =~ /consul_(\d+\.\d+\.\d+)/
      tag_version = $1
      download_url = \
        "#{node['consul']['base_binary_url']}#{tag_version}/consul_#{tag_version}_linux_#{node['consul']['arch']}.zip"
    end
  end
rescue
  # Abort the chef client process:
  raise 'Cannot connect to https://www.consul.io/downloads.html'
end

# Download `consul`
remote_file node['consul']['tmp_path'] do
  source download_url

  owner 'root'
  group 'root'
  mode 0o0644

  action :create_if_missing
  backup false
end

# Unzip consul binary
execute 'unzip consul binary' do
  cwd '/opt/consul/bin/'

  # -q = quiet, -o = overwrite existing files
  command "unzip -qo #{node['consul']['tmp_path']}"

  notifies :restart, 'service[consul]'
end

file '/opt/consul/bin/consul' do
  owner 'root'
  group 'root'

  mode 0o0755
end

# Add `consul` to /usr/bin so it is on our path
link '/usr/bin/consul' do
  to '/opt/consul/bin/consul'
end
