require 'serverspec'

set :backend, :exec

describe file('/opt/consul/bin/consul') do
  it { should be_owned_by '_consul' }
  it { should be_grouped_into '_consul' }
  it { should be_mode 755 }
end

describe file('/usr/bin/consul') do
  it { should be_linked_to '/opt/consul/bin/consul' }
end
