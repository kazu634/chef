require 'serverspec'

describe package('dstat') do
  it { should be_installed }
end

describe file('/etc/cron.d/dstat') do
  it { should be_file }

  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }

  it { should be_mode 644 }

  its(:md5sum) { should eq 'be094d8097a76db5b7e5b52317242a78' }
end

describe file('/etc/rc.local') do
  it { should be_file }

  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }

  it { should be_mode 755 }

  its(:md5sum) { should eq 'cbbca00d9c171de713d413be84f8076b' }
end
