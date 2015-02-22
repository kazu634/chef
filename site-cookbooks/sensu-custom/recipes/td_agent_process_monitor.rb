#
# Cookbook Name:: sensu-custom
# Recipe:: td_agent_process_monitor
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

sensu_check 'td-agent' do
  command 'check-procs.rb -p td-agent -c 2 -C 2'
  handlers ['default']
  subscribers ['all']
  interval 300
end
