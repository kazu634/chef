#
# Cookbook Name:: fluentd-custom
# Recipe:: hipchat
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

if node['td_agent']['forward']
  # Install prerequisite gems
  %w(fluent-plugin-slack).each do |pkg|
    td_agent_gem pkg do
      action :upgrade
    end
  end

  slack_auth = Chef::EncryptedDataBagItem.load('fluentd-custom', 'slack')

  # deploy the configuration file for hipchat notification
  template '/etc/td-agent/conf.d/watcher.conf' do
    source 'watcher.erb'

    owner 'root'
    group 'root'

    mode 0644

    variables(
      webhook_url: slack_auth['webhook_url']
    )

    notifies :restart, 'service[td-agent]'
  end
end
