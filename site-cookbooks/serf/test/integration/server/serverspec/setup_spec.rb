require 'serverspec'

set :backend,  :exec

describe file('/etc/serf/serf.json.example') do
  it { should be_file }

  it { should be_owned_by '_serf' }
  it { should be_grouped_into '_serf' }
  it { should be_mode 644 }
end

describe file('/etc/init.d/serf') do
  it { should be_file }

  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 755 }
end

describe file('/etc/init/serf.conf') do
  it { should be_file }

  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }
end

describe file('/etc/serf/serf.json') do
  it { should be_file }

  it { should be_owned_by '_serf' }
  it { should be_grouped_into '_serf' }
  it { should be_mode 644 }
end

describe file('/etc/serf/handlers/handler.rb') do
  it { should be_file }

  it { should be_owned_by '_serf' }
  it { should be_grouped_into '_serf' }
  it { should be_mode 755 }
end

%w( growthforecast slack-notify ).each do |gem|
  describe command("/opt/chef/embedded/bin/gem list | grep #{gem}") do
    its(:exit_status) { should eq 0 }
  end
end

describe iptables do
  it { should have_rule('-A FWR -p tcp -m tcp --dport 7946 -j ACCEPT') }
  it { should have_rule('-A FWR -p udp -m udp --dport 7946 -j ACCEPT') }
end
