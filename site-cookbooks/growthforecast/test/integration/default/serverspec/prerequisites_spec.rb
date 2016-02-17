require 'serverspec'

set :backend,  :exec

describe user('growth') do
  it { should exist }
  it { should have_home_directory '/var/lib/growthforecast' }
  it { should have_login_shell '/bin/bash' }
end

describe package('fonts-ipafont') do
  it { should be_installed }
end
