require 'serverspec'

set :backend, :exec

describe file('/home/kazu634/repo/chef') do
  it { should be_owned_by 'kazu634' }
  it { should be_grouped_into 'kazu634' }
end
