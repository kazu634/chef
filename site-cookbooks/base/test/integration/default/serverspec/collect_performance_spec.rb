require 'serverspec'

describe package('dstat') do
  it { should be_installed }
end

describe file('/etc/cron.d/dstat') do
  it { should be_file }

  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }

  it { should be_mode 644 }

  its(:md5sum) { should eq 'ed90023b94388b59dd7db753c2759344' }
end

describe file('/etc/rc.local') do
  it { should be_file }

  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }

  it { should be_mode 755 }

  its(:md5sum) { should eq 'c902d7adc4060daab00a1986a9f9f875' }
end
