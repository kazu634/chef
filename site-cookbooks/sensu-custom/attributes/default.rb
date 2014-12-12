# domain name
default_unless["common"]["domain"]    = 'com'

#rabbitmq
default["sensu"]["rabbitmq"]["host"]  = "rabbitmq.kazu634.#{node['common']['domain']}"

default['rabbitmq']['ssl']            = true

default['rabbitmq']['ssl_cacert']     = '/etc/rabbitmq/ssl/cacert.pem'
default['rabbitmq']['ssl_cert']       = '/etc/rabbitmq/ssl/cert.pem'
default['rabbitmq']['ssl_key']        = '/etc/rabbitmq/ssl/key.pem'

#redis
default["sensu"]["redis"]["host"]     = "redis.kazu634.#{node['common']['domain']}"

# sensu
default["sensu"]["use_embedded_ruby"] = true

#api
default["sensu"]["api"]["host"]       = "sensu-api.kazu634.#{node['common']['domain']}"

# server setting
default["sensu-custom"]["server"]     = false
default["sensu-custom"]["domain"]     = node['common']['domain']

# iptables configuration:
default['sensu-custom']['iptables']   = true
