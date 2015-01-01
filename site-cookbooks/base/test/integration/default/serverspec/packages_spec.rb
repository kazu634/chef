require 'serverspec'

describe package('zsh') do
  it { should be_installed }
end

describe package('git-core') do
  it { should be_installed }
end

describe package('vim-nox') do
  it { should be_installed }
end

describe package('debian-keyring') do
  it { should be_installed }
end

describe package('screen') do
  it { should be_installed }
end

describe package('ruby') do
  it { should be_installed }
end

if os[:release] == "12.04"
  describe package('rubygems') do
    it { should be_installed }
  end
else
  describe package('rubygems-integration') do
    it { should be_installed }
  end
end

describe package('curl') do
  it { should be_installed }
end
