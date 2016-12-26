#
# Cookbook Name:: base
# Recipe:: aws-ec2
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

if !node[:ec2].nil? && node[:ec2][:instance_type] =~ /^t2.(micro|nano)/
  bash 'create swapfile' do
    user 'root'
    code <<-EOC
    dd if=/dev/zero of=/swap.img bs=1M count=2048 &&
    chmod 600 /swap.img
    mkswap /swap.img
    EOC
    only_if 'test ! -f /swap.img -a `cat /proc/swaps | wc -l` -eq 1'
  end

  mount '/dev/null' do # swap file entry for fstab
    action :enable # cannot mount; only add to fstab
    device '/swap.img'
    fstype 'swap'
  end

  bash 'activate swap' do
    code 'swapon -ae'
    only_if 'test `cat /proc/swaps | wc -l` -eq 1'
  end
end
