# common cofiguration
default["webapp"]["ruby"]="2.0.0-p481"
default["webapp"]["home"]="/var/lib/webapp"

# domain name
default_unless['common']['domain'] = 'com'

default['webapp']['domain'] = node['common']['domain']
