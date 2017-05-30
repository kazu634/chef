require 'serverspec'

set :backend, :exec

describe package('nagios-plugins') do
  it { should be_installed }
end

describe file('/usr/lib/nagios/plugins/check_file') do
  it { should be_file }

  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 555 }
end

describe package('bc') do
  it { should be_installed }
end

describe file('/usr/lib/nagios/plugins/check_memory') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }

  it { should be_mode 555 }
end

%w(disk load ssh swap reboot-required).each do |target|
  describe file("/etc/consul.d/check-#{target}.json") do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 644 }
  end
end
