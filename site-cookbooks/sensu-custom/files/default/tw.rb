#!/usr/bin/env ruby
#
# Sensu Twitter Handler
# ===
#
# This handler reports alerts to a configured twitter handler.
# Map a twitter handle to a sensusub value in the twitter.json to get going!
# sensusub == subscription in the client object, not check..
# see twitter.json for required values
#
# Copyright 2011 Joe Crim <josephcrim@gmail.com>
#
# Released under the same terms as Sensu (the MIT license); see LICENSE
# for details.

require 'rubygems' if RUBY_VERSION < '1.9.0'
require 'sensu-handler'
require 'twitter'
require 'timeout'

class TwitterHandler < Sensu::Handler

  def event_name
    @event['client']['name'] + '/' + @event['check']['name']
  end

  def handle
    puts settings['twitter']
    settings['twitter'].each do |account|
      if @event['client']['subscriptions'].include?(account[1]["sensusub"])
        client = Twitter::REST::Client.new do |config|
          config.consumer_key = account[1]["consumer_key"]
          config.consumer_secret = account[1]["consumer_secret"]
          config.oauth_token = account[1]["oauth_token"]
          config.oauth_token_secret = account[1]["oauth_token_secret"]
        end

        if @event['action'].eql?("resolve")
          client.update("@kazu634 RESOLVED - #{event_name}: #{@event['check']['notification']} Time: #{Time.now()} ")
        else
          client.update("@kazu634 ALERT - #{event_name}: #{@event['check']['notification']} Time: #{Time.now()} ")
        end
      end
    end
  end

end
