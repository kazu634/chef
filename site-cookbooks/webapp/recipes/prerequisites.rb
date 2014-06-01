#
# Cookbook Name:: webapp
# Recipe:: prerequisites
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Use `nginx` as the front-end proxy
include_recipe "nginx"

# Create user for webapp
user "webapp" do
  comment  "User for WebApp"

  home     node['webapp']['home']
  shell    "/bin/bash"

  supports :manage_home => true

  system   true
end

# Install Ruby
include_recipe "ruby"

ruby_setup "webapp" do
  action :install

  user "webapp"
  group "webapp"

  version node['webapp']['ruby']
end

