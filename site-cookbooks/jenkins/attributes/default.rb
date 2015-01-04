# common configuration
default['jenkins']['hostname']     = 'jenkins'

# domain name
default_unless['common']['domain'] = 'com'

default['jenkins']['domain']       = "kazu634.#{node['common']['domain']}"
