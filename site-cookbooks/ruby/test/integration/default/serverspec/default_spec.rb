require 'serverspec'

set :backend,  :exec

describe package('libreadline-dev') do
  it { should be_installed }
end

describe package('libssl-dev') do
  it { should be_installed }
end

describe package('zlib1g-dev') do
  it { should be_installed }
end

describe package('libssl1.0.0') do
  it { should be_installed }
end

describe package('libxml2-dev') do
  it { should be_installed }
end

describe package('libxslt1-dev') do
  it { should be_installed }
end

describe package('libreadline6') do
  it { should be_installed }
end

describe package('libreadline6-dev') do
  it { should be_installed }
end

