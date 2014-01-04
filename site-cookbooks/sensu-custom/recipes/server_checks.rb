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
  command "/usr/bin/sudo /etc/sensu/plugins/check-load.rb -w 2,4,6 -c 3,6,9 -p"
  handlers ["default"]
  subscribers ["all"]
  interval 300
end
