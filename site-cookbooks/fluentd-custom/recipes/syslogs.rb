#
# Cookbook Name:: fluentd-custom
# Recipe:: syslogs
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# if the node is the manager:
if node['td_agent']['forward']
  # deploy the configuration file for syslog monitoring:
  %w(esxi synology vyos).each do |p|
    cookbook_file "/etc/td-agent/conf.d/syslog_#{p}.conf" do
      source "syslog_#{p}.conf"

      owner 'root'
      group 'root'

      mode 0o644

      notifies :restart, 'service[td-agent]'
    end
  end

  # include the `iptables` cookbook
  include_recipe 'iptables'

  # allow access from 24224 port
  iptables_rule 'syslog'
end
