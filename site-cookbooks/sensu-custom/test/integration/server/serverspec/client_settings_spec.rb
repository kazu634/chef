require 'serverspec'

set :backend,  :exec

describe file('/etc/sudoers.d/sensu') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }

  it { should be_mode 440 }
end

describe file('/etc/monit/conf.d/sensu-client.conf') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }

  it { should be_mode 644 }
end
