#
# Cookbook Name:: wordpress
# Recipe:: mysql
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template '/etc/mysql/my.cnf' do
  source 'my.cnf.erb'

  user 'root'
  group 'root'
  mode 0644

  notifies :restart,  'service[mysql]',  :immediately
  notifies :run, 'script[mysql setting for wordpress]'
end

service 'mysql' do
  action [:enable,   :start]
end

script 'mysql setting for wordpress' do
  interpreter 'bash'

  action :nothing

  user 'root'
  group 'root'

  code <<-EOH
  mysql -u root -p123qweASD -e "CREATE DATABASE blog;"
  mysql -u root -p123qweASD -e "GRANT ALL PRIVILEGES ON blog.* TO 'wp-db-admin'@'localhost' IDENTIFIED BY '123qweASD';"
  mysql -u root -p123qweASD -e "FLUSH PRIVILEGES;"
  EOH
end
