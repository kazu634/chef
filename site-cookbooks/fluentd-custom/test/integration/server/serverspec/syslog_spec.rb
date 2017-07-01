require 'serverspec'

set :backend, :exec

%w(esxi synology vyos).each do |p|
  describe file("/etc/td-agent/conf.d/syslog_#{p}.conf") do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 644 }
  end
end

describe iptables do
  it { should have_rule('-A FWR -p tcp -m tcp --dport 1514 -j ACCEPT') }
  it { should have_rule('-A FWR -p tcp -m tcp --dport 5140 -j ACCEPT') }
  it { should have_rule('-A FWR -p tcp -m tcp --dport 5141 -j ACCEPT') }
end
