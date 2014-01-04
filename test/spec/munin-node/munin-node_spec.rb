require 'spec_helper'

packages = %w(
  gawk
  libio-multiplex-perl
  libio-socket-inet6-perl
  liblist-moreutils-perl
  libnet-cidr-perl
  libnet-server-perl
  munin-common
  munin-doc
  munin-node
  munin-plugins-core
  munin-plugins-extra
)

packages.each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

describe file('/etc/munin/munin-node.conf') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }

  it { should match_md5checksum '085d37e5d101b4b50512e4512b2154d3' }
end

describe service('munin-node') do
  it { should be_enabled }
end

describe file('/etc/monit/conf.d/munin-node.conf') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }

  it { should match_md5checksum '977ce9d67172a13b63c9f665d7fce336' }
end

describe iptables do
  it { should have_rule '-A FWR -i eth0 -p tcp -m tcp --dport 4949 -j ACCEPT' }
end
