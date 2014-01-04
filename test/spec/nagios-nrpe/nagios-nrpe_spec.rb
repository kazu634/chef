require 'spec_helper'

%w(
  nagios-nrpe-server
  nagios-nrpe-plugin
  nagios-plugins
).each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

describe file('/etc/nagios/nrpe.cfg') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }

  it { should match_md5checksum '9913d53747baa669ed931ba1d79301c0' }
end

describe iptables do
  it { should have_rule '-A FWR -i eth0 -p tcp -m tcp --dport 5666 -j ACCEPT' }
end

describe file('/etc/sudoers.d/nagios') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 440 }

  it { should match_md5checksum 'dd52e561e8e1291c74c8fc77d8d0cf6d' }
end

describe file('/etc/nagios/nrpe.d/check_apt.cfg') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }

  it { should match_md5checksum '812c3174aa3b5447f612e5760c58fc4e' }
end

describe file('/etc/nagios/nrpe.d/check_log.cfg') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }

  it { should match_md5checksum '92d8719d916101ac99e9e8a7cd0d511a' }
end

describe file('/etc/nagios/nrpe.d/check_swap.cfg') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }

  it { should match_md5checksum 'a4cc6a8b14f1514c37581fb6c2bdaecc' }
end

describe service('nagios-nrpe-server') do
  it { should be_enabled }
end
