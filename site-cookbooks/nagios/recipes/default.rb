#
# Cookbook Name:: nagios
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "build-essential"
include_recipe "base"
include_recipe "nginx"
include_recipe "monit"

template "/etc/nginx/sites-available/nagios" do
  source "nagios.erb"

  owner "root"
  group "root"
  mode 0644
end

link "/etc/nginx/sites-enabled/nagios" do
  action :create

  owner "root"
  group "root"

  to "/etc/nginx/sites-available/nagios"

  notifies :restart, "service[nginx]"
end

pre_requisites = %w(libperl-dev libpng12-dev libgd2-xpm-dev libssl-dev spawn-fcgi fcgiwrap php5-fpm)

pre_requisites.each do |p|
  package p do
    action :install
  end
end

user "nagios" do
  shell "/bin/false"
end

remote_file "#{Chef::Config['file_cache_path']}/nagios.tar.gz" do
  source "http://prdownloads.sourceforge.net/sourceforge/nagios/nagios-3.5.0.tar.gz"

  mode 0666

  not_if "test -e /opt/nagios/bin/nagios"
end

remote_file "#{Chef::Config['file_cache_path']}/nagios-plugins.tar.gz" do
  source "http://prdownloads.sourceforge.net/sourceforge/nagiosplug/nagios-plugins-1.4.16.tar.gz"

  mode 0666

  not_if "test -e /opt/nagios/bin/nagios"
end

script "Install nagios" do
  interpreter "bash"

  cwd Chef::Config['file_cache_path']

  code <<-EOF
  tar xzf nagios.tar.gz
  tar xzf nagios-plugins.tar.gz

  cd nagios

  ./configure --prefix /opt/nagios \
  --sysconfdir=/etc/nagios \
  --with-nagios-user=nagios \
  --with-nagios-group=nagios \
  --with-command-user=nagios \
  --with-command-group=nagios \
  --with-cgiurl=/cgi-bin \
  --with-htmurl=/

  make all
  make install
  make install-init
  make install-config
  make install-commandmode

  cd ../nagios-plugins-1.4.16

  ./configure --prefix /opt/nagios \
  --with-nagios-user=nagios \
  --with-nagios-group=nagios \
  --with-cgiurl=/cgi-bin


  make
  make install

  update-rc.d -f nagios defaults
  EOF

  not_if "test -e /opt/nagios/bin/nagios"

  notifies :delete, "directory[/etc/nagios]", :immediately
end

remote_file "#{Chef::Config['file_cache_path']}/nrpe.tar.gz" do
  source "http://sourceforge.net/projects/nagios/files/nrpe-2.x/nrpe-2.14/nrpe-2.14.tar.gz/download"

  mode 0666

  not_if "test -e /opt/nagios/libexec/check_nrpe"
end

script "Install NRPE" do
  interpreter "bash"

  cwd Chef::Config['file_cache_path']

  code <<-EOF
  tar xzf nrpe.tar.gz

  cd nrpe-2.14

 ./configure --prefix=/opt/nagios/ --with-ssl=`which openssl` --with-ssl-lib=$(dirname $(dpkg -L libssl-dev | grep libssl.so$))

  make check_nrpe
  make install-plugin
  EOF

  not_if "test -e /opt/nagios/libexec/check_nrpe"
end

directory "/etc/nagios" do
  action :nothing

  recursive true
end

git "/etc/nagios" do
  repository "git://github.com/kazu634/nagios-conf.git"

  user "root"
  group "root"

  notifies :restart, "service[nagios]"
end

directory "/etc/nagios" do
  owner "root"
  group "root"
  mode 0755
end

cookbook_file "/etc/nagios/htpasswd.users" do
  source "htpasswd.users"

  owner "root"
  group "root"
  mode 0644

  notifies :restart, "service[nginx]"
end

service "nagios" do
  action [:enable, :start]
end

template "/etc/php5/fpm/pool.d/www.conf" do
  source "www.conf.erb"

  owner "root"
  group "root"
  mode 0644

  notifies :restart, "service[php5-fpm]"
end

service "php5-fpm" do
  action [:enable, :start]
end

package "httping" do
  action :install
end

cookbook_file "/etc/monit/conf.d/nagios.conf" do
  source     "nagios.conf"

  user       "root"
  group      "root"
  mode       0644

  notifies   :restart, "service[monit]"
end

cookbook_file "/etc/monit/conf.d/fcgiwrap.conf" do
  source     "fcgiwrap.conf"

  user       "root"
  group      "root"
  mode       0644

  notifies   :restart, "service[monit]"
end

cookbook_file "/etc/monit/conf.d/php5-fpm.conf" do
  source     "php5-fpm.conf"

  user       "root"
  group      "root"
  mode       0644

  notifies   :restart, "service[monit]"
end

package "whois" do
  action :install
end

cookbook_file "/usr/local/bin/check_domain" do
  source   "check_domain"

  user     "root"
  group    "root"
  mode     0755
end

package "python-pip" do
  action :install
end

script "Install tweepy" do
  interpreter "bash"

  user "root"
  group "root"

  code <<-EOF
  pip install tweepy
  EOF

  user "root"
  group "root"

  not_if "test ! -z $(find /usr/local/lib -type d -name 'tweepy')"
end

cookbook_file "/usr/local/bin/twagios" do
  source   "twagios"

  user     "root"
  group    "root"
  mode     0755
end

cookbook_file "/etc/sudoers.d/nagios" do
  source   "nagios"

  user     "root"
  group    "root"
  mode     0440
end
