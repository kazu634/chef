require 'serverspec'

set :backend,  :exec

describe file('/etc/sysctl.d/90-nginx.conf') do
  it { should be_file }

  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }

  it { should be_mode 644 }

  its(:md5sum) { should eq '9175890bdd803295a4dd6250bcee1971' }
end
