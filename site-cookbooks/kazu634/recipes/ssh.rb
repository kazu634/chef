#
# Cookbook Name:: base
# Recipe:: ssh
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

directory '/home/kazu634/.ssh' do
  owner 'kazu634'
  group 'kazu634'
  mode 0700
  action :create

  only_if 'test -e /home/kazu634'
end

# Retrieve known_hosts data from data bag
keys = []

data_bag_item('ssh_keys', 'keys')['hosts'].each do |host|
  host.each do |_item,  value|
    keys.push(value)
  end
end

template '/home/kazu634/.ssh/authorized_keys' do
  source 'authorized_keys.erb'

  owner 'kazu634'
  group 'kazu634'
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

  template "/home/kazu634/.ssh/id_rsa.#{host}" do
    source 'secret_key.erb'

    owner 'kazu634'
    group 'kazu634'
    mode 0600

    variables(
      secret_key: secret_key
    )
  end
end

cookbook_file '/home/kazu634/.ssh/config' do
  source 'config'

  owner 'kazu634'
  group 'kazu634'
  mode '0664'
end

# AWS setting

aws_data_bag = Chef::EncryptedDataBagItem.load('kazu634',  'AWS')

secret_credential = aws_data_bag['SECRET_CREDENTIAL']

template '/home/kazu634/.ssh/amazon.pem' do
  source 'amazon.pem.erb'

  owner 'kazu634'
  group 'kazu634'

  mode 0600

  variables(
    SECRET_CREDENTIAL: secret_credential
  )
end
