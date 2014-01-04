require 'spec_helper'

describe package('git-core') do
  it { should be_installed }
end

describe file('/usr/share/git-core/templates/hooks/pre-commit') do
  it { should be_readable }
  it { should be_executable }

  it { should match_md5checksum 'b599b5ada7e27cb645c55c30b4e20efe' }
end

describe file('/usr/share/git-core/templates/hooks/prepare-commit-msg') do
  it { should be_readable }
  it { should be_executable }

  it { should match_md5checksum '73b5092d2239eabf5e4f911e939b9049' }
end

describe file('/usr/local/bin/git-ticket') do
  it { should be_readable }
  it { should be_executable }

  it { should match_md5checksum '39a843d5f2c2e4d9e77f103c5e809b78' }
end
