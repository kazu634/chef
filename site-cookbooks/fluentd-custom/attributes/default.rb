# Basic configuration
default['td_agent']['api_key']      = 'foo'
default['td_agent']['version']      = '2'
default['td_agent']['forward']      = false
default['td_agent']['base']         = true
default['td_agent']['ssh']          = true

# domain configuration
default_unless['common']['domain']  = 'com'
default['fluentd-custom']['domain'] = node['common']['domain']
