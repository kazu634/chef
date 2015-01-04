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

  its(:md5sum) { should eq '19ed229ade1c3ed11be7835982d40847' }
end

describe file('/etc/monit/conf.d/td-agent.conf') do
  it { should be_file }

  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }

  it { should be_mode 644 }

  its(:md5sum) { should eq 'b540eae27614f6e3321e4c838dbda039' }
end
