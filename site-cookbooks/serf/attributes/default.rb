default['serf']['user'] = '_serf'
default['serf']['group'] = '_serf'

default['serf']['base_binary_url'] = 'https://dl.bintray.com/mitchellh/serf/'
default['serf']['version'] = '0.6.3'
default['serf']['arch'] = kernel['machine'] =~ /x86_64/ ? 'amd64' : '386'

default['serf']['binary_url'] = File.join node['serf']['base_binary_url'], "#{node['serf']['version']}_linux_#{node['serf']['arch']}.zip"

default['serf']['tmp_path'] = File.join Chef::Config[:file_cache_path], "serf-#{node['serf']['version']}_linux_#{node['serf']['arch']}.zip"

default_unless['common']['domain']  = 'com'
default['serf']['domain'] = "kazu634.#{node['common']['domain']}"

default['serf']['manager'] = false

default['serf']['iptables'] = true
