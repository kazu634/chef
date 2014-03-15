#
# Cookbook Name:: sensu-custom
# Recipe:: server_check
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

sensu_check "monit_log" do
  command "/usr/bin/sudo /etc/sensu/plugins/check-log.rb -f /var/log/monit.log -q error -s /var/tmp/"
  handlers ["default"]
  subscribers ["all"]
  interval 120
end

sensu_check "load_average" do
  command "/etc/sensu/plugins/check-load.rb -w 1,2,3 -c 2,4,6 -p"
  handlers ["default"]
  subscribers ["all"]
  interval 300
end

sensu_check "swap" do
  command "/etc/sensu/plugins/check-swap.sh -w 30 -c 60"
  handlers ["default"]
  subscribers ["all"]
  interval 3600
end

sensu_check "disk_usage" do
  command "/etc/sensu/plugins/check-disk.rb"
  handlers ["default"]
  subscribers ["all"]
  interval 3600
end

%w{ blog tech jenkins }.each do |host|
  sensu_check "#{host}.kazu634.com" do
    command "/usr/lib/nagios/plugins/check_http -H #{host}.kazu634.com -w 3 -c 5 -t 10"
    handlers ["default"]
    interval 60
    standalone true
  end
end

%w{ home router }.each do |host|
  sensu_check "#{host}.kazu634.com" do
    command "/usr/bin/sudo /usr/lib/nagios/plugins/check_ping -H #{host}.kazu634.com -w 200,30% -c 500,50%"
    handlers ["default"]
    interval 60
    standalone true
  end
end
