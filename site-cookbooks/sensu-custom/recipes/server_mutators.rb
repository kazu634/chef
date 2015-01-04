#
# Cookbook Name:: sensu-custom
# Recipe:: server_mutators
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

sensu_mutator 'growthforecast-mutator' do
  command '/etc/sensu/mutators/mutator.rb'
end
