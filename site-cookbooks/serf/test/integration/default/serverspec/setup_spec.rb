require 'serverspec'

set :backend,  :exec

describe file('/etc/serf/serf.json.example') do
  it { should be_owned_by '_serf' }
  it { should be_grouped_into '_serf' }
  it { should be_mode 644 }
end

describe file('/etc/init.d/serf') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 755 }
end

describe file('/etc/init/serf.conf') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }
end

describe file('/etc/serf/serf.json') do
  it { should be_owned_by '_serf' }
  it { should be_grouped_into '_serf' }
  it { should be_mode 644 }
end
