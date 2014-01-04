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

sensu_handler "default" do
  type      "pipe"
  command   "tw.rb"
end

sensu_handler "crit_only" do
  type       "pipe"
  command    "tw.rb"
  severities ["critical"]
end
