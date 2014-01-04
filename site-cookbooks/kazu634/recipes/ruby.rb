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

  gems ['bundler', 'rake', 'json', 'knife-ec2']
end

directory "/home/kazu634/bin" do
  owner    "kazu634"
  group    "kazu634"
  mode     0755

  action   :create
end

remote_file "#{Chef::Config[:file_cache_path]}/ec2-api-tools.zip" do
  source "http://www.amazon.com/gp/redirect.html/ref=aws_rc_ec2tools?location=http://s3.amazonaws.com/ec2-downloads/ec2-api-tools.zip&token=A80325AA4DAB186C80828ED5138633E3F49160D9"

  mode 0644

  not_if "test -e /home/kazu634/bin/ec2-api-tools"
end

script "Install ec2 api tools" do
  interpreter "bash"

  user "root"
  group "root"

  cwd "#{Chef::Config[:file_cache_path]}/"

  code <<-EOH
    unzip -o ec2-api-tools.zip
    chown -R kazu634:kazu634 ec2-api-tools*
    find `pwd` -maxdepth 1 -type d -name "ec2-api-tools*" | xargs -I % mv % /home/kazu634/bin/ec2-api-tools
  EOH

  not_if "test -e /home/kazu634/bin/ec2-api-tools"
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

directory "/home/kazu634/works/knife-ec2" do
  owner    "kazu634"
  group    "kazu634"
  mode     0775

  action   :create
end

template "/home/kazu634/works/knife-ec2/template.erb" do
  source "template.erb"

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
