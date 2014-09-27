#
# Cookbook Name:: munin-node
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "monit"

packages = %w(
  gawk
  libio-multiplex-perl
  libio-socket-inet6-perl
  liblist-moreutils-perl
  libnet-cidr-perl
  libnet-server-perl
  libjs-underscore
  libjs-jquery
  liblog-dispatch-perl
)

packages.each do |pkg|
  package pkg do
    action :install

    not_if "which munin-node"
  end
end

munin_packages = {
  "/tmp/munin-common.deb" =>
    "http://ftp.jp.debian.org/debian/pool/main/m/munin/munin-common_2.1.9-1_all.deb",
  "/tmp/munin-doc.deb" =>
    "http://ftp.jp.debian.org/debian/pool/main/m/munin/munin-doc_2.1.9-1_all.deb",
  "/tmp/munin-node.deb" =>
    "http://ftp.jp.debian.org/debian/pool/main/m/munin/munin-node_2.1.9-1_all.deb",
  "/tmp/munin-plugins-core.deb" =>
    "http://ftp.jp.debian.org/debian/pool/main/m/munin/munin-plugins-core_2.1.9-1_all.deb",
  "/tmp/munin-plugins-extra.deb" =>
    "http://ftp.jp.debian.org/debian/pool/main/m/munin/munin-plugins-extra_2.1.9-1_all.deb"
}

munin_packages.each do |dir, pkg|
  remote_file dir.dup do
    source pkg.dup

    not_if "which munin-node"
  end
end

execute "install deb packages" do
  command "dpkg -i /tmp/munin*.deb"

  user "root"
  group "root"

  not_if "which munin-node"
end

template "/etc/munin/munin-node.conf" do
  source "munin-node.conf.erb"

  action :create

  user "root"
  group "root"
  mode 0644

  notifies :restart, "service[munin-node]"
end

service "munin-node" do
  action :enable
end

cookbook_file "/etc/monit/conf.d/munin-node.conf" do
  source "munin-node.conf"

  user   "root"
  group  "root"
  mode   0644

  notifies :reload, "service[monit]"
end
