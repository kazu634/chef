#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "ruby"

ruby_setup "kazu634" do
  action :install
end

directory "/home/kazu634/bin" do
  owner    "kazu634"
  group    "kazu634"
  mode     0755

  action   :create
end

directory "/home/kazu634/.chef" do
  owner    "kazu634"
  group    "kazu634"
  mode     0775

  action   :create
end

template "/home/kazu634/.chef/knife.rb" do
  source "knife.rb.erb"

  owner "kazu634"
  group "kazu634"

  mode 0644
end

# AWS setting

aws_data_bag = Chef::EncryptedDataBagItem.load('kazu634',   'AWS')

access_key = aws_data_bag['ACCESS_KEY']
secret_key = aws_data_bag['SECRET_KEY']

template "/home/kazu634/.aws_setuprc" do
  source "aws_setuprc.erb"

  owner "kazu634"
  group "kazu634"

  mode 0600

  variables({
    :ACCESS_KEY => access_key,
    :SECRET_KEY => secret_key
  })
end

secret_credential = aws_data_bag['SECRET_CREDENTIAL']

template "/home/kazu634/.ssh/amazon.pem" do
  source "amazon.pem.erb"

  owner "kazu634"
  group "kazu634"

  mode 0600

  variables({
    :SECRET_CREDENTIAL => secret_credential
  })
end
