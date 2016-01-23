require 'serverspec'

set :backend,  :exec

describe user('webadm') do
  it { should exist }
  it { should have_home_directory '/home/webadm' }
  it { should have_login_shell '/bin/bash' }
end

describe file('/etc/sudoers.d/webadm') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 440 }
  its(:md5sum) { should eq 'fe868f5baa62eb2fde8ea7c8c304812b' }
end

describe file('/home/webadm/.ssh') do
  it { should be_owned_by 'webadm' }
  it { should be_grouped_into 'webadm' }
  it { should be_mode 700 }
end
