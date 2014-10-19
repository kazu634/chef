require 'serverspec'

set :backend, :exec

%w{ fluent-plugin-rewrite-tag-filter
    fluent-plugin-amplifier-filter
    fluent-plugin-growthforecast
    fluent-plugin-forest
    fluent-plugin-numeric-counter
    fluent-plugin-datacounter
    fluent-plugin-flowcounter
  }.each do |pkg|
    describe command("/opt/td-agent/embedded/bin/fluent-gem list | grep #{pkg}") do
      its(:exit_status) { should eq 0 }
    end
end

describe file('/etc/td-agent/conf.d/forwarder_nginx.conf') do
  it { should be_file }

  it { should be_owned_by "root" }
  it { should be_grouped_into 'root' }

  it { should be_mode 644 }

  its(:md5sum) { should eq 'a3691c8faf97379ad9f3bfa04a42ae16' }
end
