#
# Cookbook Name:: fluentd-custom
# Recipe:: hipchat
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

if node[:td_agent][:forward]
  # Install prerequisite gems
  %w{ fluent-plugin-buffered-hipchat }.each do |pkg|
    gem_package pkg do
      action :upgrade

      gem_binary '/usr/lib/fluent/ruby/bin/fluent-gem'
    end
  end

  hipchat_auth = Chef::EncryptedDataBagItem.load("fluentd-custom",  "hipchat")

  # deploy the configuration file for hipchat notification
  template "/etc/td-agent/conf.d/watcher.conf" do
    source "watcher.erb"

    owner "root"
    group "root"

    mode 0644

    variables({
      :api_token => hipchat_auth["api_token"]
    })

    notifies :restart,  "service[td-agent]"
  end
end
