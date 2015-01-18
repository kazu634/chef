require 'serverspec'

set :backend,  :exec

describe file('/opt/serf/bin/serf') do
  it { should be_file }

  it { should be_owned_by '_serf' }
  it { should be_grouped_into '_serf' }
  it { should be_mode 755 }
end

describe file('/usr/bin/serf') do
  it { should be_linked_to '/opt/serf/bin/serf' }
end
