default['consul']['base_binary_url'] = 'https://releases.hashicorp.com/consul/'
default['consul']['arch']            = \
  node['kernel']['machine'] =~ /x86_64/ ? 'amd64' : '386'

default['consul']['tmp_path'] = \
  File.join Chef::Config[:file_cache_path], 'consul.zip'

default['consul']['manager'] = false
default['consul']['manager_hosts'] = '["192.168.10.110", "192.168.10.101", "192.168.10.111", "192.168.10.115"]'
