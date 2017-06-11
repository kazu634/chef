default['consul-template']['base_binary_url'] = 'https://releases.hashicorp.com/consul-template/'
default['consul-template']['arch']            = \
  node['kernel']['machine'] =~ /x86_64/ ? 'amd64' : '386'

default['consul-template']['tmp_path'] = \
  File.join Chef::Config[:file_cache_path], 'consul-template.zip'
