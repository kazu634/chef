require 'serverspec'

set :backend, :exec

describe file('/etc/supervisor/conf.d/node_exporter.conf') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }
end

describe iptables do
  it { should have_rule('-A FWR -p tcp -m tcp --dport 9100 -j ACCEPT') }
end
