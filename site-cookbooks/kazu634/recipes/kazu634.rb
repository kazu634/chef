#
# Cookbook Name:: base
# Recipe:: kazu634
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

user "kazu634" do
  home "/home/kazu634"
  shell "/bin/zsh"
  password "$1$7Zch2rSt$XEFT8T9XS24gY1rctRLtA1"

  supports :manage_home => true
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

