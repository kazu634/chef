require 'serverspec'

set :backend, :exec

describe file('/home/kazu634/.ssh') do
  it { should be_directory }
  it { should be_owned_by 'kazu634' }
  it { should be_grouped_into 'kazu634' }
  it { should be_mode 700 }
end

describe file('/home/kazu634/.ssh/authorized_keys') do
  it { should be_file }
  it { should be_owned_by 'kazu634' }
  it { should be_grouped_into 'kazu634' }
  it { should be_mode 700 }
end

describe file('/home/kazu634/.ssh/id_rsa.bitbucket') do
  it { should be_file }
  it { should be_owned_by 'kazu634' }
  it { should be_grouped_into 'kazu634' }
  it { should be_mode 600 }

  its(:md5sum) { should eq '8a5d7e12f56529ec6f2780905007b703' }
end

describe file('/home/kazu634/.ssh/id_rsa.chef') do
  it { should be_file }
  it { should be_owned_by 'kazu634' }
  it { should be_grouped_into 'kazu634' }
  it { should be_mode 600 }

  its(:md5sum) { should eq '37086e711fa7bf46d618f23d91feaa4f' }
end

describe file('/home/kazu634/.ssh/id_rsa.github') do
  it { should be_file }
  it { should be_owned_by 'kazu634' }
  it { should be_grouped_into 'kazu634' }
  it { should be_mode 600 }

  its(:md5sum) { should eq '86b365bb51904196f7cd6a819f097d6b' }
end

describe file('/home/kazu634/.ssh/config') do
  it { should be_file }
  it { should be_owned_by 'kazu634' }
  it { should be_grouped_into 'kazu634' }
  it { should be_mode 664 }

  its(:md5sum) { should eq 'cfd932386f80899637bddbd55a4adb2e' }
end

describe file('/home/kazu634/.ssh/amazon.pem') do
  it { should be_owned_by 'kazu634' }
  it { should be_grouped_into 'kazu634' }
  it { should be_mode 600 }
end
