# default values:

default['prometheus']['manager']     = false

default['prometheus']['url']         = 'https://github.com/prometheus/prometheus/releases/download/'
default['prometheus']['prefix']      = 'prometheus-'
default['prometheus']['postfix']     = '.linux-amd64.tar.gz'
default['prometheus']['location']    = '/usr/bin'

default['node_exporter']['url']      = 'https://github.com/prometheus/node_exporter/releases/download/'
default['node_exporter']['prefix']   = 'node_exporter-'
default['node_exporter']['postfix']  = '.linux-amd64.tar.gz'
default['node_exporter']['location'] = '/usr/bin'
