require 'serverspec'

set :backend, :exec

%w(/etc/prometheus.d /etc/prometheus.d/targets/).each do |d|
  describe file(d) do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 755 }
  end
end

describe file('/etc/prometheus.d/prometheus.yml') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }
end

describe file('/etc/prometheus.d/targets/targets.yml') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }
end

describe file('/etc/consul-template.d/prometheus-targets.tmpl') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }
end

describe file('/etc/supervisor/conf.d/prometheus-targets.conf') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }
end

describe file('/etc/supervisor/conf.d/prometheus.conf') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }
end

describe iptables do
  it { should have_rule('-A FWR -p tcp -m tcp --dport 9090 -j ACCEPT') }
end
