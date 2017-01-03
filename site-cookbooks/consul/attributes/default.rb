default['consul']['user']  = '_consul'
default['consul']['group'] = '_consul'

default['consul']['base_binary_url'] = 'https://releases.hashicorp.com/consul/'
default['consul']['arch']            = \
  kernel['machine'] =~ /x86_64/ ? 'amd64' : '386'

default['consul']['tmp_path'] = \
  File.join Chef::Config[:file_cache_path], 'consul.zip'
