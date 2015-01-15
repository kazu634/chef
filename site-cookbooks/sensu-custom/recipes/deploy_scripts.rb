#
# Cookbook Name:: sensu-custom
# Recipe:: deploy_scripts
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

remote_file '/etc/sensu/plugins/check-procs.rb' do
  source 'https://raw.github.com/sensu/sensu-community-plugins/master/plugins/processes/check-procs.rb'

  user 'sensu'
  group 'sensu'
  mode 0755
end

remote_file '/etc/sensu/plugins/check-load.rb' do
  source 'https://raw.github.com/sensu/sensu-community-plugins/master/plugins/system/check-load.rb'

  user 'sensu'
  group 'sensu'
  mode 0755
end

remote_file '/etc/sensu/plugins/check-swap.sh' do
  source 'https://raw.github.com/sensu/sensu-community-plugins/master/plugins/system/check-swap.sh'

  user 'sensu'
  group 'sensu'
  mode 0755
end

remote_file '/etc/sensu/plugins/check-disk.rb' do
  source 'https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/plugins/system/check-disk.rb'
  user 'sensu'
  group 'sensu'
  mode 0755
end

remote_file '/etc/sensu/plugins/check-file-exists.rb' do
  source 'https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/plugins/files/check-file-exists.rb'
  user 'sensu'
  group 'sensu'
  mode 0755
end

# Slack notification:
remote_file '/etc/sensu/handlers/slack.rb' do
  source 'https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/handlers/notification/slack.rb'

  user 'sensu'
  group 'sensu'
  mode 0755
end

# Sensu-Growthforecast integration:
remote_file '/etc/sensu/plugins/cpu-pcnt-usage-metrics.rb' do
  source 'https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/plugins/system/cpu-pcnt-usage-metrics.rb'

  user 'sensu'
  group 'sensu'
  mode 0755
end

remote_file '/etc/sensu/plugins/disk-usage-metrics.rb' do
  source 'https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/plugins/system/disk-usage-metrics.rb'

  user 'sensu'
  group 'sensu'
  mode 0755
end

remote_file '/etc/sensu/plugins/load-metrics.rb' do
  source 'https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/plugins/system/load-metrics.rb'

  user 'sensu'
  group 'sensu'
  mode 0755
end

remote_file '/etc/sensu/plugins/memory-metrics.rb' do
  source 'https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/plugins/system/memory-metrics.rb'

  user 'sensu'
  group 'sensu'
  mode 0755
end

remote_file '/etc/sensu/plugins/metrics-net.rb' do
  source 'https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/plugins/network/metrics-net.rb'

  user 'sensu'
  group 'sensu'
  mode 0755
end

remote_file '/etc/sensu/plugins/metrics-netstat-tcp.rb' do
  source 'https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/plugins/network/metrics-netstat-tcp.rb'

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
