#
# Cookbook Name:: notification
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

chef_gem 'chef-handler-slack' do
  action :upgrade
end

require 'chef/handler/slack'

slack = Chef::EncryptedDataBagItem.load('notification', 'slack')

chef_handler 'Chef::Handler::SlackReporting' do
  source 'chef/handler/slack'
  arguments [
    # The name of your team registered with Slack
    team: 'kazu634',

    # Your incoming webhook token
    token: slack['token'],

    # An existing channel
    channel: '#chef',

    # Watever.
    icon_emoj: ':chef:'
  ]
  action :nothing
end.run_action(:enable)
