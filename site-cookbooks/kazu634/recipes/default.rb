#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apt"
include_recipe "build-essential"
include_recipe "base"

gem_package "ruby-shadow" do
  action :install
end

user "kazu634" do
  home "/home/kazu634"
  shell "/bin/zsh"
  password "$1$7Zch2rSt$XEFT8T9XS24gY1rctRLtA1"

  supports :manage_home => true
end

git "/home/kazu634/.vim" do
  repo "git://github.com/kazu634/vim.git"
  destination "/home/kazu634/.vim"
  revision "master"
  user "kazu634"
  group "kazu634"
  action :sync
end

directory "/home/kazu634/.vim/bundle/" do
  owner "kazu634"
  group "kazu634"
  mode 0755
  action :create
end

git "neobundle" do
  repo          "git://github.com/Shougo/neobundle.vim"
  destination   "/home/kazu634/.vim/bundle/neobundle.vim"
  user          "kazu634"
  group         "kazu634"
  action        :sync
end

directory "/home/kazu634/repo" do
  owner "kazu634"
  group "kazu634"
  mode 0755
  action :create
end

git "git-now" do
  repo              "git://github.com/iwata/git-now.git"
  destination       "/home/kazu634/repo/git-now"
  user              "kazu634"
  group             "kazu634"
  action            :sync
  enable_submodules true
end

script "install git-now" do
  interpreter   "bash"

  code <<-EOH
    cd /home/kazu634/repo/git-now && make install
  EOH

  user          "root"
  group         "root"

  not_if        "which git-now"
end

git "rcfiles" do
  repo          "git://github.com/kazu634/dotfiles.git"
  destination   "/home/kazu634/repo/dotfiles"
  user          "kazu634"
  group         "kazu634"
  action        :sync

  notifies :run, "script[install rcfiles]"
end

script "install rcfiles" do
  interpreter   "bash"

  cwd           "/home/kazu634/repo/dotfiles"

  code <<-EOH
    su - kazu634 -c "/home/kazu634/repo/dotfiles/install.sh"
  EOH

  user          "root"
  group         "root"
end

directory "/home/kazu634/.ssh" do
  owner     "kazu634"
  group     "kazu634"
  mode      0700
  action    :create

  only_if   "test -e /home/kazu634"
end

# Retrieve known_hosts data from data bag
keys = []

for host in data_bag_item('ssh_keys',  'keys')['hosts']
  host.each do |item,  value|
    keys.push(value)
  end
end

template "/home/kazu634/.ssh/authorized_keys" do
  source "authorized_keys.erb"

  owner "kazu634"
  group "kazu634"
  mode 0700

  variables({
    :keys => keys
  })
end

# SSH secret key for Chef execution
ssh_data_bag = Chef::EncryptedDataBagItem.load('kazu634', 'ssh_keys')

secret_key_data = ssh_data_bag['secret_keys']

for data in secret_key_data
  host = data["name"]
  secret_key = data["secret_key"]

  template "/home/kazu634/.ssh/id_rsa.#{host}" do
    source "secret_key.erb"

    owner "kazu634"
    group "kazu634"
    mode 0600

    variables({
      :secret_key => secret_key
    })
  end
end

cookbook_file "/home/kazu634/.ssh/config" do
  source   "config"

  owner    "kazu634"
  group    "kazu634"
  mode     "0664"
end

cookbook_file "/etc/sudoers.d/kazu634" do
  source   "kazu634"

  owner    "root"
  group    "root"
  mode     "0440"
end

directory "/home/kazu634/src" do
  owner "kazu634"
  group "kazu634"
  mode 0755
  action :create
end

directory "/home/kazu634/tmp" do
  owner "kazu634"
  group "kazu634"
  mode 0755
  action :create
end

cookbook_file "/etc/cron.d/remove_tmp" do
  source   "remove_tmp"

  owner    "root"
  group    "root"
  mode     "0644"
end

directory "/home/kazu634/works" do
  owner "kazu634"
  group "kazu634"
  mode 0755
  action :create
end


# AWS setting

aws_data_bag = Chef::EncryptedDataBagItem.load('kazu634',  'AWS')

access_key = aws_data_bag['ACCESS_KEY']
secret_key = aws_data_bag['SECRET_KEY']

template "/home/kazu634/.aws_setuprc" do
  source "aws_setuprc.erb"

  owner "kazu634"
  group "kazu634"

  mode 0600

  variables({
    :ACCESS_KEY => access_key,
    :SECRET_KEY => secret_key
  })
end

if node['kazu634']['ruby_support']
  include_recipe "kazu634::ruby"
  include_recipe "kazu634::repo"
end
