require 'serverspec'

set :backend, :exec

describe package('cron-apt') do
  it { should be_installed }
end

describe file('/etc/cron-apt/config') do
  it { should be_file }

  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }

  its(:md5sum) { should eq '667914d673b618b4f45b3692a41f96e8' }
end

describe file('/etc/cron-apt/action.d/3-download') do
  it { should be_file }

  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }

  its(:md5sum) { should eq 'ff89c62ee7ce7724d055927332be8433' }
end

describe file('/etc/apt/security.sources.list') do
  it { should be_file }

  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }
end

describe file('/var/log/cron-apt/log') do
  it { should be_file }

  it { should be_owned_by 'root' }
  it { should be_grouped_into 'adm' }
  it { should be_mode 640 }
end
