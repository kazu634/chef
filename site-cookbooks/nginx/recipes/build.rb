#
# Cookbook Name:: nginx
# Recipe:: setup
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apt'
include_recipe 'nginx::webadm'

# ---
# Variables & Constants
USER = 'webadm'
GROUP = 'webadm'

WORKDIR = '/home/webadm/nginx-build/'
TARBALL = '/home/webadm/nginx-build/nginx-build.tar.gz'
NGINXBUILD = '/home/webadm/nginx-build/nginx-build'

version = node['nginx']['version']
# ---

%w( libgeoip-dev curl ).each do |p|
  package p do
    action :install
  end
end

directory WORKDIR do
  owner USER
  group GROUP
  mode 0755
end

unless File.exist?(NGINXBUILD)
  bash 'Download nginx-build' do
    cwd WORKDIR
    code <<-EOH
    latest=$(curl -fsSI https://github.com/cubicdaiya/nginx-build/releases/latest | tr -d '\r' | awk -F'/' '/^Location:/{print $NF}')
    curl -fsSL https://github.com/cubicdaiya/nginx-build/releases/download/${latest}/nginx-build-linux-amd64-${latest/v/}.tar.gz -o #{TARBALL}
    EOH
    user USER
    group GROUP
  end

  bash 'extract nginx-build' do
    cwd WORKDIR
    code <<-EOH
    tar xf #{TARBALL}
    chown webadm:webadm #{NGINXBUILD}
    EOH
    user USER
    group GROUP
  end
end

cookbook_file "#{WORKDIR}/configure.sh" do
  source 'configure.sh'
  owner USER
  group GROUP
  mode 0755
  action :create
end

bash 'Build nginx' do
  cwd WORKDIR
  code <<-EOH
    #{NGINXBUILD} -d working -v #{version} -c configure.sh -zlib -pcre -openssl
  EOH
  user USER

  not_if { File.exist?("#{WORKDIR}/working/nginx/#{version}/nginx-#{version}/objs") }
end

bash 'Install nginx' do
  cwd "#{WORKDIR}/working/nginx/#{version}/nginx-#{version}/"
  code <<-EOH
    make install
  EOH
  user 'root'

  not_if "/usr/share/nginx/sbin/nginx -v 2>&1 | grep #{version}"
end

cookbook_file '/etc/init.d/nginx' do
  source 'nginx'
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

bash 'Auto-start nginx when OS boots up' do
  code <<-EOH
    update-rc.d nginx defaults
  EOH
  user 'root'
end
