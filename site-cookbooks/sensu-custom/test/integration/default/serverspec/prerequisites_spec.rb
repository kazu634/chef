require 'serverspec'

set :backend,  :exec

describe command('/opt/sensu/embedded/bin/gem list | grep sensu-plugin') do
  its(:exit_status) { should eq 0 }
end

describe file('/opt/sensu/embedded/ssl/cert.pem') do
  it { should be_file }

  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }

  it { should be_mode 644 }
end
