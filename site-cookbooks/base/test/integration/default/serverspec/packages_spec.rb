require 'serverspec'

describe package('zsh') do
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

if os[:release] == '12.04'
  describe package('ruby') do
    it { should be_installed }
  end

  describe package('rubygems') do
    it { should be_installed }
  end
elsif os[:release] == '14.04'
  describe package('ruby2.0') do
    it { should be_installed }
  end

  %w(erb gem testrb irb rake ruby ri rdoc).each do |cmd|
    describe file("/usr/bin/#{cmd}") do
      it { should be_linked_to "/usr/bin/#{cmd}2.0" }
    end
  end
end

describe package('curl') do
  it { should be_installed }
end
