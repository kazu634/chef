require 'spec_helper'

describe file('/etc/localtime') do
  it { should be_file }
  it { should match_md5checksum 'f17769e8eb35e7a08cfedfe9b2f6b5ef' }
end

describe file('/etc/timezone') do
  it { should be_file }
  it { should match_md5checksum '5fb64d575eb1b84e443741f1fb4e5e3c' }
end
