require 'spec_helper'

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

describe package('git-core') do
  it { should be_installed }
end

