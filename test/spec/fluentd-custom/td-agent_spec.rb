require 'spec_helper'

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
