#
# Cookbook Name:: redmine
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apt"
include_recipe "base"
include_recipe "nginx"
include_recipe "monit"
include_recipe "ruby"

gem_package "ruby-shadow" do
  action :install
end

user "redmine" do
  home "/home/redmine"
  password "$1$4tqF0u1E$bQkXGCh0B7zAdMjL/fy16/"

  shell "/bin/bash"

  supports :manage_home => true
end

cookbook_file "/home/redmine/.profile" do
  source "profile"

  owner "redmine"
  group "redmine"

  mode 0644
end

prerequisite_package_for_gem = %w{mysql-server libmysqlclient-dev libmagickwand-dev}

prerequisite_package_for_gem.each do |p|
  package p do
    action :install

    response_file "mysql.seed"

    notifies :run, "script[mysql setting]", :immediately
  end
end

ruby_setup "redmine" do
  action :install

  version '1.9.3-p392'

  gems ['bundler', 'mysql2', 'unicorn']
end

service "mysql" do
  action [ :enable,  :start ]
end

template "/etc/mysql/my.cnf" do
  source "my.cnf.erb"

  user "root"
  group "root"
  mode 0644

  notifies :restart, "service[mysql]", :immediately
end

script "mysql setting" do
  interpreter "bash"

  action :nothing

  user "root"
  group "root"

  code <<-EOH
  ps -ef | grep "[m]ysqld" || exec /usr/sbin/mysqld &

  sleep 10

  mysql -u root -p123qweASD -e "create database redmine character set utf8;"
  mysql -u root -p123qweASD -e "create user 'redmine'@'localhost' identified by 'ZAQ!2wsx';"
  mysql -u root -p123qweASD -e "grant all privileges on redmine.* to 'redmine'@'localhost';"
  EOH
end

git "/home/redmine/redmine" do
  action        :sync

  repo          "git://github.com/redmine/redmine"
  destination   "/home/redmine/redmine"
  revision      "master"

  user          "redmine"
  group         "redmine"

  not_if "test -e /home/redmine/redmine"

  notifies :create, "template[/home/redmine/redmine/config/database.yml]", :immediately
end

template "/home/redmine/redmine/config/database.yml" do
  action :nothing

  source "database.yml.erb"

  owner "redmine"
  group "redmine"
  mode 0644

  notifies :run, "script[Setting up Redmine.]", :immediately
end

cookbook_file "/home/redmine/redmine/Gemfile.local" do
  source "Gemfile.local"

  owner "redmine"
  group "redmine"
  mode 0644
end

script "Setting up Redmine." do
  action :nothing

  interpreter "bash"

  user "redmine"
  group "redmine"

  cwd "/home/redmine/redmine"

  code <<-EOH
   /home/redmine/.rbenv/shims/bundle install --without test development
   /home/redmine/.rbenv/shims/bundle exec rake generate_secret_token
   /home/redmine/.rbenv/shims/bundle exec rake db:migrate RAILS_ENV=production
  EOH
end

template "/home/redmine/redmine/config/unicorn.rb" do
  source "unicorn.rb.erb"

  owner "redmine"
  group "redmine"
  mode 0644
end

directory "/home/redmine/repo/" do
  owner   "redmine"
  group   "redmine"
  mode    0755
end

cookbook_file "/home/redmine/repo/update-repo.sh" do
  owner   "redmine"
  group   "redmine"
  mode    0755
end

template "/etc/nginx/sites-available/redmine" do
  action :create
  source "redmine.erb"

  owner "root"
  group "root"
  mode 0644

  notifies :restart, "service[nginx]"
end

link "/etc/nginx/sites-enabled/redmine" do
  to "/etc/nginx/sites-available/redmine"

  not_if "test -e /etc/nginx/sites-enabled/redmine"
end

cookbook_file "/etc/init.d/redmine" do
  source "redmine.init"

  owner "root"
  group "root"
  mode 0755

  notifies :run, "script[Enable init script]", :immediately
end

script "Enable init script" do
  action :nothing

  interpreter "bash"

  user "root"
  group "root"

  code <<-EOH
  update-rc.d redmine remove
  update-rc.d redmine defaults
  EOH
end

service "redmine" do
  action [:start, :enable]
end

template "/etc/monit/conf.d/redmine.conf" do
  source "redmine.conf.erb"

  owner "root"
  group "root"
  mode 0644

  notifies :reload, "service[monit]"
end
