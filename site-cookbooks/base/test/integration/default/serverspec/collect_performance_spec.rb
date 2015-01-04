require 'serverspec'

describe package('dstat') do
  it { should be_installed }
end

describe file('/etc/cron.d/dstat') do
  it { should be_file }

  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }

  it { should be_mode 644 }

  its(:md5sum) { should eq '7609f1b32368d01fa671c80085971bce' }
end

describe file('/etc/rc.local') do
  it { should be_file }

  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }

  it { should be_mode 755 }

  its(:md5sum) { should eq 'e1e975c666ce08e21c2e43f07b9889eb' }
end
