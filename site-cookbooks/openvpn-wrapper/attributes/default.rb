# Listen IP
default["openvpn"]["local"] = "0.0.0.0"
default["openvpn"]["proto"] = "tcp"
default["openvpn"]["port"] = "1194"
default["openvpn"]["type"] = "server"
default["openvpn"]["subnet"] = "10.8.0.0"
default["openvpn"]["netmask"] = "255.255.0.0"

# Endpoint
default["openvpn"]["gateway"] = node['ipaddress']
default["openvpn"]["log"] = "/var/log/openvpn.log"
default["openvpn"]["key_dir"] = "/etc/openvpn/keys"
default["openvpn"]["signing_ca_key"]  = "#{node["openvpn"]["key_dir"]}/ca.key"
default["openvpn"]["signing_ca_cert"] = "#{node["openvpn"]["key_dir"]}/ca.crt"
default["openvpn"]["routes"] = []
default["openvpn"]["script_security"] = 1
default["openvpn"]["user"] = "nobody"
default["openvpn"]["group"] = "nogroup"

# SSL Certificates
default["openvpn"]["key"]["ca_expire"] = 3650
default["openvpn"]["key"]["expire"] = 3650
default["openvpn"]["key"]["size"] = 1024
default["openvpn"]["key"]["country"] = "JP"
default["openvpn"]["key"]["province"] = "Tokyo"
default["openvpn"]["key"]["city"] = "Yanaka"
default["openvpn"]["key"]["org"] = "kazu634.com"
default["openvpn"]["key"]["email"] = "simoom634@gmail.com"
