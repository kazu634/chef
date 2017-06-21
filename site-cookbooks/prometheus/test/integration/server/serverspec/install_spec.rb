require 'serverspec'

set :backend, :exec

describe file('/usr/bin/prometheus') do
  it { should be_owned_by 'root' }
  it { should be_owned_by 'root' }
  it { should be_mode 755 }
end
