require 'serverspec'

set :backend, :exec

describe package('td-agent') do
  it { should be_installed }
end

describe service('td-agent') do
  it { should be_enabled }
  it { should be_running }
end

describe file('/etc/td-agent/conf.d') do
  it { should be_directory }

  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }

  it { should be_mode 755 }
end

describe file('/etc/td-agent/td-agent.conf') do
  it { should be_file }

  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }

  it { should be_mode 644 }

  its(:md5sum) { should eq 'fbca8726eb307de22c011a3c292dc438' }
end

describe file('/etc/monit/conf.d/td-agent.conf') do
  it { should be_file }

  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }

  it { should be_mode 644 }

  its(:md5sum) { should eq 'b540eae27614f6e3321e4c838dbda039' }
end

describe user('td-agent') do
  it { should belong_to_group 'adm' }
end

describe file('/etc/td-agent/conf.d/forwarder.conf') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }
end

describe file('/etc/hosts') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }

  its(:content) { should match /primary.td-agent.service.consul/ }
  its(:content) { should match /backup.td-agent.service.consul/ }
end

describe file('/etc/td-agent/conf.d/forwarder_td-agent.conf') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }
end
