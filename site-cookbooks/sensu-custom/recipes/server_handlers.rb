#
# Cookbook Name:: sensu-custom
# Recipe:: server_handlers
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

slack_auth = Chef::EncryptedDataBagItem.load('sensu', 'slack')

sensu_snippet 'slack' do
  content(webhook_url: slack_auth['webhook_url'],
          message_prefix: '<!channel> ',
          surround: '',
          bot_name: 'kazu-chan')
end

sensu_handler 'slack' do
  type 'pipe'
  command 'slack.rb'
end

sensu_handler 'default' do
  type 'set'
  handlers %w(slack)
end

sensu_handler 'growthforecast' do
  type 'pipe'
  command 'growthforecast-handler.rb'
  mutator 'growthforecast-mutator'
end
