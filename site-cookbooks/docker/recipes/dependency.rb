#
# Cookbook Name:: docker
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

platform = ['ubuntu']
platform_ver = ['12.04', '13.04']

if platform.include?(node['platform']) and platform_ver.include?(node['platform_version'])

  %w{linux-image-generic-lts-raring linux-headers-generic-lts-raring apt-transport-https}.each do |pkg|
    package pkg do
      action :install

      not_if "test -z ${DOCKER}"
    end
  end

else

  log "Docker does not support this platform." do
    level :warn
  end

end
