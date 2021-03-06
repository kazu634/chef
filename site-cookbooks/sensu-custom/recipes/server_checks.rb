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
    additional(occurrences: 3)
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

%w(home tagajo).each do |host|
  sensu_check "#{host}.kazu634.com" do
    command "/usr/bin/sudo /usr/lib/nagios/plugins/check_ping -H #{host}.kazu634.com -w 200,30% -c 500,50%"
    handlers ['default']
    interval 60
    standalone true
    additional(occurrences: 3)
  end
end

sensu_check 'reboot-required' do
  command '/etc/sensu/plugins/check-file-exists.rb -c /var/run/reboot-required'
  handlers ['default']
  subscribers ['all']
  interval 3600
  additional(subdue: { begin: '00:00 JST', end: '22:59 JST' })
end

sensu_check 'check-ssl-cert' do
  command 'check-ssl-cert.rb -h blog.kazu634.com -w 30 -c 15 -p 443'
  handlers ['default']
  interval 86400
  standalone true
end
