require 'serverspec'

set :backend,  :exec

describe package('git') do
  it { should be_installed }
end

describe file('/home/webadm/letsencrypt') do
  it { should be_owned_by 'webadm' }
  it { should be_grouped_into 'webadm' }
end
