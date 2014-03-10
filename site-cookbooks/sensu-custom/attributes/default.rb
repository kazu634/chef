# installation
default["sensu"]["version"]               = "0.12.3-1"
default["sensu"]["use_unstable_repo"]     = false
default["sensu"]["directory"]             = "/etc/sensu"
default["sensu"]["log_directory"]         = "/var/log/sensu"
default["sensu"]["log_level"]             = "info"
default["sensu"]["use_ssl"]               = true
default["sensu"]["use_embedded_ruby"]     = true
default["sensu"]["init_style"]            = "sysv"
default["sensu"]["service_max_wait"]      = 10

default["sensu"]["apt_repo_url"]          = "http://repos.sensuapp.org/apt"
default["sensu"]["yum_repo_url"]          = "http://repos.sensuapp.org"
default["sensu"]["msi_repo_url"]          = "http://repos.sensuapp.org/msi"

#rabbitmq
default["sensu"]["rabbitmq"]["host"]      = "rabbitmq.kazu634.com"
default["sensu"]["rabbitmq"]["port"]      = 5671
default["sensu"]["rabbitmq"]["vhost"]     = "/sensu"
default["sensu"]["rabbitmq"]["user"]      = "sensu"
default["sensu"]["rabbitmq"]["password"]  = "password"

#redis
default["sensu"]["redis"]["host"]         = "redis.kazu634.com"
default["sensu"]["redis"]["port"]         = 6379

#api
default["sensu"]["api"]["host"]           = "sensu-api.kazu634.com"
default["sensu"]["api"]["bind"]           = "0000"
default["sensu"]["api"]["port"]           = 4567

#dashboard
default["sensu"]["dashboard"]["bind"]     = "0.0.0.0"
default["sensu"]["dashboard"]["port"]     = 8080
default["sensu"]["dashboard"]["user"]     = "admin"
default["sensu"]["dashboard"]["password"] = "secret"

# server setting
default["sensu-custom"]["server"]         = false
