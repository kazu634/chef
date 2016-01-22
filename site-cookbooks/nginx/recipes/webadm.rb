#
# Cookbook Name:: nginx
# Recipe:: letsencrypt
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

user 'webadm' do
  comment 'User for nginx Admin'
  home '/home/webadm'
  shell '/bin/bash'
  password '$1$lzfGward$TODNAMe9S9v.BXqpCV0p60'
  supports manage_home: true
end

cookbook_file '/etc/sudoers.d/webadm' do
  source 'webadm'
  owner 'root'
  group 'root'
  mode 0440
end

directory '/home/webadm/.ssh' do
  owner 'webadm'
  group 'webadm'
  mode 0700
  action :create

  only_if 'test -e /home/webadm'
end

# Retrieve known_hosts data from data bag
keys = []

data_bag_item('ssh_keys', 'keys')['hosts'].each do |host|
  host.each do |_item, value|
    keys.push(value)
  end
end

template '/home/webadm/.ssh/authorized_keys' do
  source 'authorized_keys.erb'

  owner 'webadm'
  group 'webadm'
  mode 0700

  variables(
    keys: keys
  )
end

# SSH secret key for Chef execution
ssh_data_bag = Chef::EncryptedDataBagItem.load('kazu634', 'ssh_keys')

secret_key_data = ssh_data_bag['secret_keys']

secret_key_data.each do |data|
  host = data['name']
  secret_key = data['secret_key']

  template "/home/webadm/.ssh/id_rsa.#{host}" do
    source 'secret_key.erb'

    owner 'webadm'
    group 'webadm'
    mode 0600

    variables(
      secret_key: secret_key
    )
  end
end
