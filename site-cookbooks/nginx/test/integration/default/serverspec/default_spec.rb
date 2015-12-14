require 'serverspec'

set :backend,  :exec

describe package('nginx') do
  it { should be_installed }
end

describe file('/etc/nginx/nginx.conf') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }

  its(:md5sum) { should eq '62450662229d2ce4a33f0316c1218547' }
end

describe file('/etc/nginx/sites-available/default') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }

  its(:md5sum) { should eq 'f1eb3e4bceb46f2ca9030f2beb1867fc' }
end

describe file('/usr/share/nginx/html/index.html') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }
end

describe service('nginx') do
  it { should be_enabled }
end

describe file('/etc/monit/conf.d/nginx.conf') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }

  its(:md5sum) { should eq '4d7f0276e7efea61d687a2886cfa5569' }
end

describe port(80) do
  it { should be_listening.with('tcp') }
end

describe iptables do
  it { should have_rule '-A FWR -p tcp -m tcp --dport 80 -j ACCEPT' }
end
