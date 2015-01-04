#
# Cookbook Name:: docker
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'docker::dependency'

apt_repository 'docker' do
  uri 'https://get.docker.io/ubuntu'

  components ['main']
  distribution 'docker'

  key 'http://get.docker.io/gpg'
end

package 'lxc-docker' do
  action :install

  options '--force-yes'
end

# if ec2, ln -s /mnt/docker /var/lib/docker
if (!node['ec2'].nil?) && node['ec2']['instace_type'] != 't1.micro'
  directory '/var/lib/docker' do
    action :delete
    recursive true

    not_if 'test -L /var/lib/docker'
  end

  directory '/mnt/docker' do
    action :create

    owner 'root'
    group 'root'
    mode 0755
  end

  link '/var/lib/docker' do
    to '/mnt/docker'

    owner 'root'
    group 'root'

    not_if 'test -L /var/lib/docker'
  end
end

script 'Pulling Ubuntu image' do
  interpreter 'bash'

  user 'root'
  group 'root'

  code <<-EOH
  docker pull ubuntu
  EOH
end
