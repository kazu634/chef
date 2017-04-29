require 'serverspec'

set :backend, :exec

describe package('nagios-plugins') do
  it { should be_installed }
end

%w(disk load ssh swap).each do |target|
  describe file("/etc/consul.d/check-#{target}.json") do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 644 }
  end
end
