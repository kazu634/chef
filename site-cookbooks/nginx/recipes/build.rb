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

package 'libgeoip-dev' do
  action :install
end

directory WORKDIR do
  owner USER
  group GROUP
  mode 0755
end

unless File.exist?(NGINXBUILD)
  remote_file TARBALL do
    source 'https://github.com/cubicdaiya/nginx-build/releases/download/v0.6.5/nginx-build-linux-amd64-0.6.5.tar.gz'
    owner USER
    group GROUP
    mode 0755
  end

  bash 'extract nginx-build' do
    cwd WORKDIR
    code <<-EOH
    tar xf #{TARBALL}
    chown webadm:webadm #{WORKDIR}/nginx-build
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

  not_if { File.exist?('/usr/share/nginx/sbin/nginx') }
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
