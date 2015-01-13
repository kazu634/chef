#
# Cookbook Name:: sensu-custom
# Recipe:: server_check
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

sensu_check 'load_average' do
  command '/etc/sensu/plugins/check-load.rb -w 1,1,1 -c 2,2,2 -p'
  handlers ['default']
  subscribers ['all']
  interval 300
end

sensu_check 'swap' do
  command '/etc/sensu/plugins/check-swap.sh -w 150 -c 300'
  handlers ['default']
  subscribers ['all']
  interval 86400
end

sensu_check 'disk_usage' do
  command '/etc/sensu/plugins/check-disk.rb'
  handlers ['default']
  subscribers ['all']
  interval 3600
end

%w(blog.kazu634.com everun.club).each do |host|
  sensu_check host do
    command "/usr/lib/nagios/plugins/check_http -H #{host} -w 3 -c 5 -t 10"
    handlers ['default']
    interval 60
    standalone true
  end
end

basic_auth = Chef::EncryptedDataBagItem.load('sensu', 'auth')
%w(sensu.kazu634.com growth.kazu634.com).each do |site|
  sensu_check site do
    command "/usr/lib/nagios/plugins/check_http -H #{site} -w 3 -c 5 -t 10 -a #{basic_auth[site]}"
    handlers ['default']
    interval 60
    standalone true
  end
end

%w(home).each do |host|
  sensu_check "#{host}.kazu634.com" do
    command "/usr/bin/sudo /usr/lib/nagios/plugins/check_ping -H #{host}.kazu634.com -w 200,30% -c 500,50%"
    handlers ['default']
    interval 60
    standalone true
  end
end

# Sensu-Growthforecast integration:
sensu_check 'cpu-pcnt-usage-metrics' do
  type 'metric'
  command 'cpu-pcnt-usage-metrics.rb --scheme host:`uname -n`.cpu'
  handlers ['growthforecast']
  subscribers ['all']
  interval 62
end

sensu_check 'disk-usage-metrics' do
  type 'metric'
  command 'disk-usage-metrics.rb --scheme host:`uname -n`.disk_usage -f'
  handlers ['growthforecast']
  subscribers ['all']
  interval 900
end

sensu_check 'load-metrics' do
  type 'metric'
  command 'load-metrics.rb --scheme host:`uname -n`'
  handlers ['growthforecast']
  subscribers ['all']
  interval 64
end

sensu_check 'memory-metrics' do
  type 'metric'
  command 'memory-metrics.rb --scheme host:`uname -n`.memory'
  handlers ['growthforecast']
  subscribers ['all']
  interval 64
end

sensu_check 'metrics-net' do
  type 'metric'
  command 'metrics-net.rb --scheme host:`uname -n`.interface'
  handlers ['growthforecast']
  subscribers ['all']
  interval 68
end

sensu_check 'metrics-netstat-tcp' do
  type 'metric'
  command 'metrics-netstat-tcp.rb --scheme host:`uname -n`.netstat'
  handlers ['growthforecast']
  subscribers ['all']
  interval 70
end
