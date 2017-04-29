require 'serverspec'

set :backend, :exec

describe file('/etc/dnsmasq.conf') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }

  its(:md5sum) { should eq '647a7102a75f92efa86692c356ee646b' }
end

describe file('/etc/resolvconf/resolv.conf.d/head') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }

  its(:md5sum) { should eq '3f61630b06b3404613547a81bd5d3a66' }
end
