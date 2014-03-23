require 'spec_helper'

describe file('/home/kazu634/.ssh') do
  it { should be_directory }
  it { should be_mode 700 }
end

describe file('/home/kazu634/.ssh/authorized_keys') do
  it { should be_file }
  it { should be_mode 700 }
end

describe file('/home/kazu634/.ssh/id_rsa.bitbucket') do
  it { should be_file }
  it { should be_mode 600 }
  it { should match_md5checksum '8a5d7e12f56529ec6f2780905007b703' }
end

describe file('/home/kazu634/.ssh/id_rsa.chef') do
  it { should be_file }
  it { should be_mode 600 }
  it { should match_md5checksum '37086e711fa7bf46d618f23d91feaa4f' }
end

describe file('/home/kazu634/.ssh/id_rsa.github') do
  it { should be_file }
  it { should be_mode 600 }
  it { should match_md5checksum '86b365bb51904196f7cd6a819f097d6b' }
end

describe file('/home/kazu634/.ssh/config') do
  it { should be_file }
  it { should be_mode 664 }
  it { should match_md5checksum '4fe67db8d596501f778e82eba5861f22' }
end
