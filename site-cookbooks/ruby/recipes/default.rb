#
# Cookbook Name:: ruby
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apt"
include_recipe "build-essential"
include_recipe "base"

pre_requisites = %w{libreadline-dev libssl-dev zlib1g-dev libssl1.0.0 libxml2-dev libxslt-dev libreadline6 libreadline6-dev }

pre_requisites.each do |p|
  package p do
    action :install
  end
end
