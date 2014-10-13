require 'serverspec'

describe package('ntp') do
  it { should be_installed }
end

describe file('/etc/ntp.conf') do
  it { should be_file }

  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }

  it { should be_mode 644 }

  its(:md5sum) { should eq 'cbf21e68da1be1dfd983899041f23ae1' }
end
