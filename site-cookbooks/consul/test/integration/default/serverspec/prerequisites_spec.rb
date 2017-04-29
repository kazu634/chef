require 'serverspec'

set :backend, :exec

describe package('unzip') do
  it { should be_installed }
end

describe package('dnsmasq') do
  it { should be_installed }
end

describe group('_consul') do
  it { should exist }
end

describe user('_consul') do
  it { should exist }
  it { should belong_to_group '_consul' }
  it { should have_home_directory '/nonexistent' }
end

%w(/etc/consul.d /var/opt/consul /opt/consul/bin).each do |d|
  describe file(d) do
    it { should be_directory }
    it { should be_owned_by '_consul' }
    it { should be_mode 755 }
  end
end
