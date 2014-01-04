#
# Cookbook Name:: nagios
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

if ! node['recipes'].include?('nagios')

  include_recipe "build-essential"
  include_recipe "base"
  include_recipe "monit"
  include_recipe "iptables"

  pre_requisites = %w(nagios-nrpe-server nagios-nrpe-plugin nagios-plugins)

  pre_requisites.each do |p|
    package p do
      action :install

      options "--no-install-recommends"
    end
  end

  template "/etc/nagios/nrpe.cfg" do
    source "nrpe.cfg.erb"

    owner "root"
    group "root"
    mode 0644

    notifies :restart, "service[nagios-nrpe-server]"
  end

  iptables_rule "nrpe"

  template "/etc/sudoers.d/nagios" do
    source "nagios_sudoers.erb"

    owner "root"
    group "root"
    mode 0440
  end

  template "/etc/nagios/nrpe.d/check_apt.cfg" do
    source "check_apt.erb"

    owner "root"
    group "root"
    mode 0644

    notifies :restart, "service[nagios-nrpe-server]"
  end

  template "/etc/nagios/nrpe.d/check_log.cfg" do
    source "check_log.erb"

    owner "root"
    group "root"
    mode 0644

    notifies :restart, "service[nagios-nrpe-server]"
  end

  template "/etc/nagios/nrpe.d/check_swap.cfg" do
    source "check_swap.erb"

    owner "root"
    group "root"
    mode 0644

    notifies :restart, "service[nagios-nrpe-server]"
  end

  service "nagios-nrpe-server" do
    action [ :enable,  :start ]
  end
end
