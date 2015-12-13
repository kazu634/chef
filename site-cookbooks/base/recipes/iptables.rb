#
# Cookbook Name:: base
# Recipe:: iptables
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'iptables'

# `iptables` basic configurations:
iptables_rule 'all_established'
iptables_rule 'all_icmp'
iptables_rule 'postfix'
iptables_rule 'prefix'

# Log the Dropped Packets to `/var/log/syslog`:
iptables_rule 'packet_drop_log'
