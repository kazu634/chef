require 'serverspec'

describe package('dstat') do
  it { should be_installed }
end

describe file('/etc/cron.d/dstat') do
  it { should be_file }

  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }

  it { should be_mode 644 }

  its(:md5sum) { should eq '28375c25e5d1d336cf7282bffebfd29e' }
end

describe file('/etc/rc.local') do
  it { should be_file }

  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }

  it { should be_mode 755 }

  its(:md5sum) { should eq '2df94e67d37efb47ff11014fbe5beb0e' }
end
