require 'serverspec'

set :backend,  :exec

describe user('webapp') do
  it { should exist }
  it { should have_home_directory '/var/lib/webapp' }
  it { should have_login_shell '/bin/bash' }
end
