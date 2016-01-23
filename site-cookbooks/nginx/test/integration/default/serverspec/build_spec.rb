require 'serverspec'

set :backend,  :exec

describe package('libgeoip-dev') do
  it { should be_installed }
end

describe file('/home/webadm/nginx-build/') do
  it { should be_owned_by 'webadm' }
  it { should be_grouped_into 'webadm' }
  it { should be_mode 755 }
end

describe file('/home/webadm/nginx-build/nginx-build') do
  it { should be_owned_by 'webadm' }
  it { should be_grouped_into 'webadm' }
end

describe file('/home/webadm/nginx-build/configure.sh') do
  it { should be_owned_by 'webadm' }
  it { should be_grouped_into 'webadm' }
  it { should be_mode 755 }
end

describe file('/usr/share/nginx/sbin/nginx') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/etc/init.d/nginx') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 755 }

  its(:md5sum) { should eq '885c68de80a088fba6e2195ddb5782f2' }
end

describe service('nginx') do
  it { should be_enabled }
end
