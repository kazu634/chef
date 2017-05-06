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

  its(:md5sum) { should eq 'd15e94359cbd9570909f4a0ba23ee11a' }
end

describe file('/etc/cron-apt/action.d/3-download') do
  it { should be_file }

  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }

  its(:md5sum) { should eq 'cab15cb06be6c0d5bcc3625f2a59b6a3' }
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
