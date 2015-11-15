require 'serverspec'

set :backend, :exec

describe command('dpkg --print-architecture | grep amd64') do
  its(:exit_status) { should eq 0 }
end

describe file('/etc/sudoers.d') do
  it { should be_directory }

  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }

  it { should be_mode 755 }
end

describe file('/etc/motd.tail') do
  it { should be_file }

  it { should be_readable }

  its(:md5sum) { should eq 'bb890cfc316f0875511576ad1d5599bc' }
end

if os[:release].to_f >= 14.04 && os[:family] == 'ubuntu'
  describe file('/etc/update-motd.d/99-motd-update') do
    it { should be_file }

    it { should be_mode 755 }

    its(:md5sum) { should eq '864ab49c4f5e857ef7f87bec0b129e1d' }
  end
end

# `iptables` rule to log the dropped packets:
describe iptables do
  it { should have_rule '-A FWR -m limit --limit 3/hour -j LOG --log-prefix' }
end
