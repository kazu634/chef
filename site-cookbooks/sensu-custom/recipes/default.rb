#
# Cookbook Name:: sensu-custom
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'build-essential'

include_recipe 'monit'

include_recipe 'sensu::default'

include_recipe 'sensu-custom::prerequisites'
include_recipe 'sensu-custom::nagios_plugins'

include_recipe 'sensu-custom::client_settings'
include_recipe 'sensu-custom::deploy_scripts'

if node['sensu-custom']['server']
  include_recipe 'sensu::rabbitmq'
  include_recipe 'sensu::redis'
  include_recipe 'sensu::server_service'
  include_recipe 'sensu::api_service'

  include_recipe 'nginx'
  include_recipe 'uchiwa'

  include_recipe 'sensu-custom::server_settings'

  # Modify the redis configuration for it to start successfully
  # (older version of redis does not support the settings,
  #  the redis cookbook deploys.)
  script 'modify the redis configuration' do
    interpreter 'bash'

    user 'root'
    group 'root'

    code <<-EOH
    sed -ie "s/^notify-keyspace-events/# notify-keyspace-events/" /etc/redis/6379.conf
    EOH

    only_if "grep '^notify-' /etc/redis/6379.conf"
  end

  # The Erlang that Ubuntu 12.04 installs does not apply the patch,
  # which solves the SSL poodle attack problem.
  # In order to workaround this issue in Ubuntu 12.04 environment,
  # add "ssl_allow_poodle_attack,  true" to the configuration file.
  script 'modify the Rabbitmq configuration to allow SSL poodle attack' do
    interpreter 'bash'

    user 'root'
    group 'root'

    code <<-EOH
    TARGET_CNF="/etc/rabbitmq//rabbitmq.config"

    # check whether `ssl_allow_poodle_attack` configuration already exists?:
    grep 'ssl_allow_poodle_attack' ${TARGET_CNF} > /dev/null
    RC=$?

    # if it does not, add the configuration:
    if [ ${RC} -gt 0 ]; then
      LINE=$(grep -n 5671 ${TARGET_CNF} | cut -f 1 -d ':')

      sed -i "${LINE}a {ssl_allow_poodle_attack, true}," ${TARGET_CNF}

    fi

    exit 0
    EOH

    only_if { node['platform_version'] == '12.04' }

    notifies :restart, 'service[rabbitmq-server]'
  end
end

include_recipe 'sensu::client_service'

# Deploy the `fluentd` configuration file for
#   - monitoring `Sensu` related logs:
#   - monitoring `fluentd` processes:
if node['recipes'].include?('fluentd-custom')
  include_recipe 'sensu-custom::log_monitor'
  include_recipe 'sensu-custom::td_agent_process_monitor'
end
