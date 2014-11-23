# common configuration
default["growthforecast"]["perl"]   = "perl-5.19.10"
default["growthforecast"]["home"]   = "/var/lib/growthforecast"

# domain name
default_unless["common"]["domain"]  = 'com'

default['growthforecast']['domain'] = node['common']['domain']
