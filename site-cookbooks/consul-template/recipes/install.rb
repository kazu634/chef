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

  uri = URI.parse('https://releases.hashicorp.com/consul-template/')

  timeout(3) do
    response = Net::HTTP.get_response(uri)

    if response.body =~ /consul-template_(\d+\.\d+\.\d+)/
      tag_version = $1
      download_url = \
        "#{node['consul-template']['base_binary_url']}#{tag_version}/consul-template_#{tag_version}_linux_#{node['consul-template']['arch']}.zip"
    end
  end
rescue
  # Abort the chef client process:
  raise 'Cannot connect to https://releases.hashicorp.com/consul-template/'
end

# Download `consul-template`
remote_file node['consul-template']['tmp_path'] do
  source download_url

  owner 'root'
  group 'root'
  mode 0o0644

  action :create_if_missing
  backup false
end

# Unzip consul-template binary
execute 'unzip consul-template binary' do
  cwd '/opt/consul/bin/'

  # -q = quiet, -o = overwrite existing files
  command "unzip -qo #{node['consul-template']['tmp_path']}"

  notifies :run, 'bash[Reload supervisor]'
end

file '/opt/consul/bin/consul-template' do
  owner 'root'
  group 'root'

  mode 0o0755
end

# Add `consul-template` to /usr/bin so it is on our path
link '/usr/bin/consul-template' do
  to '/opt/consul/bin/consul-template'
end
