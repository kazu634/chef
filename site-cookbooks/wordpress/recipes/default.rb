#
# Cookbook Name:: wordpress
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "nginx"

# prerequisite package installation:
pre_requisites = %w{php5-common php5-cgi php5-cli php5-mysql php5-gd php5-fpm mysql-server}

pre_requisites.each do |p|
  package p do
    action :install

    response_file "mysql.seed"

  end
end

template "/etc/mysql/my.cnf" do
  source "my.cnf.erb"

  user "root"
  group "root"
  mode 0644

  notifies :restart,  "service[mysql]",  :immediately
  notifies :run, "script[mysql setting for wordpress]"
end

service "mysql" do
  action [ :enable,   :start ]
end

template "/etc/php5/fpm/pool.d/www.conf" do
  source "www.conf.erb"

  owner "root"
  group "root"
  mode 0644

  notifies :restart, "service[php5-fpm]"
end

service "php5-fpm" do
  action :nothing
end

cookbook_file "/etc/nginx/conf.d/wordpress_proxy.conf" do
  source "wordpress_proxy.conf"

  owner "root"
  group "root"
  mode 0644

  notifies :reload, "service[nginx]"
end

template "/etc/nginx/sites-available/wordpress" do
  source "wordpress.erb"

  owner "root"
  group "root"
  mode 0644

  notifies :reload, "service[nginx]"
end

link "/etc/nginx/sites-enabled/wordpress" do
  to "/etc/nginx/sites-available/wordpress"
end

directories = %w{/var/www/nginx-default/domain/wordpress}

tmp_directories = %w{/var/www/proxy/blog_cache
                     /var/www/proxy/blog_tmp}

directories.each do |d|
  directory d do
   owner "www-data"
   group "root"
   mode 0755
   recursive true
  end
end

tmp_directories.each do |d|
  directory d do
   owner "www-data"
   group "root"
   mode 0755
   recursive true
  end

  mount d do
    pass 0
    fstype "tmpfs"
    device "tmpfs"
    options "size=50m,noatime"
    action [:mount, :enable]

    not_if "test -z ${DOCKER}"
  end
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

script "mysql setting for wordpress" do
  interpreter "bash"

  action :nothing

  user "root"
  group "root"

  code <<-EOH
  mysql -u root -p123qweASD -e "CREATE DATABASE blog;"
  mysql -u root -p123qweASD -e "GRANT ALL PRIVILEGES ON blog.* TO 'wp-db-admin'@'localhost' IDENTIFIED BY '123qweASD';"
  mysql -u root -p123qweASD -e "FLUSH PRIVILEGES;"
  EOH
end

cookbook_file "/etc/cron.d/ktai-entry" do
  source "ktai-entry"

  owner "root"
  group "root"
  mode 0644
end
