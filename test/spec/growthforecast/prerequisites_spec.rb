require 'spec_helper'

describe package('rrdtool') do
  it { should be_installed }
end

describe user('growthforecast') do
  it { should exist }
  it { should have_home_directory '/var/lib/growthforecast' }
  it { should have_login_shell '/bin/bash' }
end
