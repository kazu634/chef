#
# Cookbook Name:: sensu-custom
# Recipe:: log_monitor
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Install prerequisite gems
%w(fluent-plugin-rewrite-tag-filter
   fluent-plugin-grep
).each do |pkg|
  td_agent_gem pkg do
    action :upgrade
  end
end

# check `/var/log/td-agent/td-agent.log` to check whether `td-agent` is working properly.
sensu_check 'td-agent-log' do
  command "/usr/bin/sudo /etc/sensu/plugins/check-log.rb -f /var/log/td-agent/td-agent.log --pattern '.*' --exclude '(info|^ |</ROOT>)' -s /var/tmp/"
  handlers ['default']
  subscribers ['all']
  interval 600

  only_if { node['sensu-custom']['server'] }
end

# deploy the configuration file for monitoring /var/log/sensu/sensu-client.log
cookbook_file '/etc/td-agent/conf.d/forwarder_sensu-client.conf' do
  source 'forwarder_sensu-client.conf'

  owner 'root'
  group 'root'

  mode 0644

  notifies :restart, 'service[td-agent]'
end

# deploy the configuration file for processing /var/log/sensu/sensu-client.log
cookbook_file '/etc/td-agent/conf.d/processor_sensu-client.conf' do
  source 'processor_sensu-client.conf'

  owner 'root'
  group 'root'

  mode 0644

  # if the node is the fluentd manager:
  only_if { node['td_agent']['forward'] }

  notifies :restart, 'service[td-agent]'
end

# Deploy `td-agent` configuration file for `Sensu` server:
if node['sensu-custom']['server']
  # deploy the configuration file for monitoring /var/log/sensu/sensu-server.log
  cookbook_file '/etc/td-agent/conf.d/forwarder_sensu-server.conf' do
    source 'forwarder_sensu-server.conf'

    owner 'root'
    group 'root'

    mode 0644

    notifies :restart, 'service[td-agent]'
  end

  # deploy the configuration file for processing /var/log/sensu/sensu-server.log
  cookbook_file '/etc/td-agent/conf.d/processor_sensu-server.conf' do
    source 'processor_sensu-server.conf'

    owner 'root'
    group 'root'

    mode 0644

    # if the node is the fluentd manager:
    only_if { node['td_agent']['forward'] }

    notifies :restart, 'service[td-agent]'
  end
end
