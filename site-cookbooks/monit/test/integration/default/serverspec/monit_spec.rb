require 'serverspec'

set :backend, :exec

describe package('monit') do
  it { should be_installed }
end

describe file('/etc/monit/monitrc') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 600 }
end

case
when os[:release].to_f < 16.04
  describe file('/etc/init/monit.conf') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 644 }

    its(:md5sum) { should eq 'b8ac9f6d996a2ebf75ada70e8a8f2ccb' }
  end

when os[:release].to_f == 16.04
  describe file('/etc/default/monit') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 644 }

    its(:md5sum) { should eq 'fefff9cbb2e664c6a69c5035228b41fd' }
  end

  describe file('/lib/systemd/system/monit.service') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 644 }

    its(:md5sum) { should eq '47e2ee0dd03988bbe596847a5b5c9300' }
  end
end
