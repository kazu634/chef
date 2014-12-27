#
# Cookbook Name:: wordpress
# Recipe:: wordpress
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

directory '/var/www/nginx-default/domain/wordpress' do
  owner "www-data"
  group "root"
  mode 0755
  recursive true
end

tmp_directories = %w{/var/www/proxy/blog_cache
                     /var/www/proxy/blog_tmp}

tmp_directories.each do |d|
  directory d do
   owner "www-data"
   group "root"
   mode 0755
   recursive true
  end
end

mount '/var/www/proxy/blog_cache' do
  pass 0
  fstype "tmpfs"
  device "tmpfs"
  options "size=100m,noatime"
  action [:mount, :enable]

  notifies :create, "directory[/var/www/proxy/blog_cache]"
end

mount '/var/www/proxy/blog_tmp' do
  pass 0
  fstype "tmpfs"
  device "tmpfs"
  options "size=5m,noatime"
  action [:mount, :enable]

  notifies :create, "directory[/var/www/proxy/blog_tmp]"
end

remote_file "#{Chef::Config['file_cache_path']}/wordpress.tgz" do
  source "http://ja.wordpress.org/latest-ja.tar.gz"

  owner "www-data"
  group "root"

  mode 0644

  not_if "test -d /var/www/nginx-default/domain/wordpress/wp-content"
  notifies :run, "script[unarchive wordpress]", :immediately
end

script "unarchive wordpress" do
  interpreter "bash"

  user "www-data"
  group "root"

  code <<-EOH
  tar xzf #{Chef::Config['file_cache_path']}/wordpress.tgz -C /var/www/nginx-default/domain/

  chown -R www-data:root /var/www/nginx-default/domain/wordpress
  EOH

  not_if "test -d /var/www/nginx-default/domain/wordpress/wp-content"
end
