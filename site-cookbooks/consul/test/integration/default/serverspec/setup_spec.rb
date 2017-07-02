require 'serverspec'

set :backend, :exec

describe file('/etc/supervisor/conf.d/consul.conf') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }
end

describe file('/etc/consul.d/config.json') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }
end

describe file('/etc/monit/conf.d/consul.conf') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }
end

describe iptables do
  it { should have_rule('-A FWR -p tcp -m tcp --dport 8300 -j ACCEPT') }
  it { should have_rule('-A FWR -p tcp -m tcp --dport 8301 -j ACCEPT') }
  it { should have_rule('-A FWR -p udp -m udp --dport 8301 -j ACCEPT') }
  it { should have_rule('-A FWR -p tcp -m tcp --dport 8500 -j ACCEPT') }
end
