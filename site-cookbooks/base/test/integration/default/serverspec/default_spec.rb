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
