require 'serverspec'

set :backend, :exec

describe package('unzip') do
  it { should be_installed }
end

describe package('dnsmasq') do
  it { should be_installed }
end

%w(/etc/consul.d /var/opt/consul /opt/consul/bin).each do |d|
  describe file(d) do
    it { should be_directory }
    it { should be_owned_by 'root' }
    it { should be_mode 755 }
  end
end
