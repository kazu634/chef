require 'serverspec'

set :backend, :exec

%w(fluent-plugin-rewrite-tag-filter
   fluent-plugin-grep
).each do |pkg|
  describe command("/opt/td-agent/embedded/bin/fluent-gem list | grep #{pkg}") do
    its(:exit_status) { should eq 0 }
  end
end

describe file('/etc/td-agent/conf.d/forwarder_aptitude.conf') do
  it { should be_file }

  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }

  it { should be_mode 644 }
end
