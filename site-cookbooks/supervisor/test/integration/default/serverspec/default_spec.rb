require 'serverspec'

set :backend, :exec

describe package('supervisor') do
  it { should be_installed }
end

describe service('supervisor') do
  it { should be_enabled }
  it { should be_running }
end
