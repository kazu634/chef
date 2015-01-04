require 'serverspec'

set :backend,  :exec

describe package('nagios-plugins') do
  it { should be_installed }
end
