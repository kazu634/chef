#
# Cookbook Name:: sensu-custom
# Recipe:: deploy_scripts
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

remote_file '/etc/sensu/plugins/check-procs.rb' do
  source 'https://raw.githubusercontent.com/sensu-plugins/sensu-plugins-process-checks/master/bin/check-process.rb'

  user 'sensu'
  group 'sensu'
  mode 0755
end

remote_file '/etc/sensu/plugins/check-log.rb' do
  source 'https://raw.githubusercontent.com/sensu-plugins/sensu-plugins-logs/master/bin/check-log.rb'

  user 'sensu'
  group 'sensu'
  mode 0755
end

remote_file '/etc/sensu/plugins/check-load.rb' do
  source 'https://raw.githubusercontent.com/sensu-plugins/sensu-plugins-load-checks/master/bin/check-load.rb'

  user 'sensu'
  group 'sensu'
  mode 0755
end

remote_file '/etc/sensu/plugins/check-swap.sh' do
  source 'https://raw.githubusercontent.com/sensu-plugins/sensu-plugins-memory-checks/master/bin/check-swap.sh'

  user 'sensu'
  group 'sensu'
  mode 0755
end

remote_file '/etc/sensu/plugins/check-disk.rb' do
  source 'https://raw.githubusercontent.com/sensu-plugins/sensu-plugins-disk-checks/master/bin/check-disk-usage.rb'
  user 'sensu'
  group 'sensu'
  mode 0755
end

remote_file '/etc/sensu/plugins/check-file-exists.rb' do
  source 'https://raw.githubusercontent.com/sensu-plugins/sensu-plugins-filesystem-checks/master/bin/check-file-exists.rb'
  user 'sensu'
  group 'sensu'
  mode 0755
end

# Slack notification:
remote_file '/etc/sensu/handlers/slack.rb' do
  source 'https://raw.githubusercontent.com/sensu-plugins/sensu-plugins-slack/master/bin/handler-slack.rb'

  user 'sensu'
  group 'sensu'
  mode 0755
end

directory '/etc/sensu/mutators' do
  owner 'root'
  group 'sensu'
  mode 0755
end

remote_file '/etc/sensu/mutators/mutator.rb' do
  source 'https://gist.githubusercontent.com/kazu634/e44711faee1c2b55b088/raw/d70ce4cca46cd36d7afb16521c5ac91445773aa6/mutator.rb'

  user 'sensu'
  group 'sensu'
  mode 0755
end

remote_file '/etc/sensu/handlers/growthforecast-handler.rb' do
  source 'https://gist.githubusercontent.com/kazu634/e44711faee1c2b55b088/raw/a690a34201409218d0d59fa066d661f561bbb145/growthforecast-handler.rb'

  user 'sensu'
  group 'sensu'
  mode 0755
end

remote_file '/etc/sensu/plugins/check-ssl-cert.rb' do
  source 'https://raw.githubusercontent.com/sensu-plugins/sensu-plugins-ssl/master/bin/check-ssl-cert.rb'

  user 'sensu'
  group 'sensu'
  mode 0755
end
