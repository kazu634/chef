require 'serverspec'

set :backend, :exec

describe file('/etc/td-agent/conf.d/forwarder_auth.conf') do
  it { should be_file }

  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }

  it { should be_mode 644 }
end
