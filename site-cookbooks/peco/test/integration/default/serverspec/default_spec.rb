require 'serverspec'

set :backend, :exec

describe file('/usr/local/bin/peco') do
  it { should be_file }

  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }

  it { should be_mode 755 }
end

describe command('/usr/local/bin/peco --version') do
  its(:stdout) { should be_include 'peco: v' }
end
