#
# Cookbook Name:: base
# Recipe:: packages
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'zsh' do
  action :install

  not_if 'which zsh'
end

apt_repository 'git' do
  uri 'http://ppa.launchpad.net/git-core/ppa/ubuntu'
  distribution node['lsb']['codename']
  components ['main']
  keyserver 'keyserver.ubuntu.com'
  key 'E1DF1F24'
end

package 'git-core' do
  action :install

  options '--force-yes'
end

include_recipe 'base::git_config'

package 'vim-nox' do
  action :install
end

package 'debian-keyring' do
  action :install
end

package 'screen' do
  action :install
end

# Ruby installation
case node['platform']
when 'ubuntu'
  # For Ubuntu 14.04:
  if 14.04 == node['platform_version'].to_f
    package 'ruby2.0' do
      action :install
    end

    # see: http://ayucat.hatenablog.com/entry/2014/07/21/115416
    %w(erb gem testrb irb rake ri rdoc ruby).each do |cmd|
      link "/usr/bin/#{cmd}" do
        to "/usr/bin/#{cmd}2.0"

        not_if { `/usr/bin/ruby -v`.include?('2.0.0') }
      end
    end

  # For Ubuntu 12.04:
  elsif 12.04 == node['platform_version'].to_f
    package 'ruby' do
      action :install
    end

    package 'rubygems' do
      action :install
    end
  end
end

# curl installation:
package 'curl' do
  action :install
end
