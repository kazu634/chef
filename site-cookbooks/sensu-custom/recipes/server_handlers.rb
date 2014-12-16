#
# Cookbook Name:: sensu-custom
# Recipe:: server_handlers
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

twitter_auth = Chef::EncryptedDataBagItem.load("sensu", "twitter")

sensu_snippet "twitter" do
    content(:default => {
      :sensusub           => "all",
      :consumer_key       => twitter_auth["consumer_key"],
      :consumer_secret    => twitter_auth["consumer_secret"],
      :oauth_token        => twitter_auth["oauth_token"],
      :oauth_token_secret => twitter_auth["oauth_token_secret"]
    })
end

hipchat_auth = Chef::EncryptedDataBagItem.load("sensu", "hipchat")

sensu_snippet "hipchat" do
    content(
      :apikey     => hipchat_auth["apikey"],
      :apiversion => "v2",
      :room       => "Kazu634-ops",
      :from       => "Sensu"
    )
end

sensu_handler "twitter" do
  type      "pipe"
  command   "tw.rb"
end

sensu_handler "hipchat" do
  type      "pipe"
  command   "hipchat.rb"
end

sensu_handler "default" do
  type      "set"
  handlers   [ "twitter", "hipchat" ]
end

sensu_handler "crit_only" do
  type       "pipe"
  command    "tw.rb"
  severities ["critical"]
end

sensu_handler "growthforecast" do
  type "pipe"
  command "growthforecast-handler.rb"
  mutator "growthforecast-mutator"
end
