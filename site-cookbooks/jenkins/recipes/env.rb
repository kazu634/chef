#
# Cookbook Name:: jenkins
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'ruby'

ruby_setup 'jenkins' do
  action :install

  user 'jenkins'
  group 'nogroup'
end

jenkins_home_dir = `grep "^jenkins" /etc/passwd | cut -f 6 -d ":"`.chomp!

directory "#{jenkins_home_dir}/.ssh" do
  action :create

  owner 'jenkins'
  group 'nogroup'

  mode 0700
end

cookbook_file "#{jenkins_home_dir}/.ssh/config" do
  source 'config'

  owner 'jenkins'
  group 'nogroup'

  mode 0644
end

# SSH secret key for Chef execution
ssh_data_bag = Chef::EncryptedDataBagItem.load('kazu634',  'ssh_keys')

secret_key_data = ssh_data_bag['secret_keys']

secret_key_data.each do |data|
  host = data['name']
  secret_key = data['secret_key']

  template "#{jenkins_home_dir}/.ssh/id_rsa.#{host}" do
    source 'secret_key.erb'

    owner 'jenkins'
    group 'nogroup'
    mode 0600

    variables(
      secret_key: secret_key
    )
  end
end

# Git configuration
cookbook_file "#{jenkins_home_dir}/.gitconfig" do
  source 'gitconfig'

  owner 'jenkins'
  group 'nogroup'

  mode 0644
end

# sudoers
cookbook_file '/etc/sudoers.d/jenkins' do
  source 'jenkins'

  owner 'root'
  group 'root'
  mode 0440
end
