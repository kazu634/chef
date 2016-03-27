#
# Cookbook Name:: sensu-custom
# Recipe:: prerequisites
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

remote_file '/opt/sensu/embedded/ssl/cert.pem' do
  source 'http://curl.haxx.se/ca/cacert.pem'

  owner 'root'
  group 'root'
  mode 0644
end

%w(sensu-plugin growthforecast erubis sys-filesystem).each do |p|
  # for installation
  gem_package p do
    action :upgrade
    retries 3
    gem_binary('/opt/sensu/embedded/bin/gem')
  end
end
