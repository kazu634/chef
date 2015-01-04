# common configuration
default['wordpress']['hostname'] = 'blog'

default_unless['common']['domain']  = 'com'
default['wordpress']['domain'] = "kazu634.#{node['common']['domain']}"
