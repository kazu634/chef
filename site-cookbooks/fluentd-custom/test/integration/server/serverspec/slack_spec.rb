require 'serverspec'

set :backend, :exec

%w(fluent-plugin-slack).each do |pkg|
  describe command("/opt/td-agent/embedded/bin/fluent-gem list | grep #{pkg}") do
    its(:exit_status) { should eq 0 }
  end
end

describe file('/etc/td-agent/conf.d/watcher.conf') do
  it { should be_file }

  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }

  it { should be_mode 644 }

  its(:md5sum) { should eq '62a3abc63603f428eb873a2467799629' }
end
