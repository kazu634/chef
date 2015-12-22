require 'serverspec'

describe package('git-core') do
  it { should be_installed }
end

describe file('/usr/share/git-core/templates/hooks/pre-commit') do
  it { should be_readable }
  it { should be_executable }

  its(:md5sum) { should eq 'b599b5ada7e27cb645c55c30b4e20efe' }
end

describe file('/usr/share/git-core/templates/hooks/prepare-commit-msg') do
  it { should be_readable }
  it { should be_executable }

  its(:md5sum) { should eq '73b5092d2239eabf5e4f911e939b9049' }
end

describe file('/usr/share/git-core/templates/hooks/pre-push') do
  it { should be_readable }
  it { should be_executable }

  its(:md5sum) { should eq 'd2655c1c0d3315556ba2b1eea2b0b45e' }
end
