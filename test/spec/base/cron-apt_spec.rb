require 'spec_helper'

describe package('cron-apt') do
  it { should be_installed }
end

describe file('/etc/cron-apt/config') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should match_md5checksum '667914d673b618b4f45b3692a41f96e8' }
end

describe file('/etc/cron-apt/action.d/3-download') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should match_md5checksum 'ff89c62ee7ce7724d055927332be8433' }
end

describe file('/etc/apt/security.sources.list') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end
