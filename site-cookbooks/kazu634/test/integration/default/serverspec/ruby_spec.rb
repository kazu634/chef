require 'serverspec'

set :backend, :exec

describe file('/home/kazu634/bin') do
  it { should be_owned_by 'kazu634' }
  it { should be_grouped_into 'kazu634' }
  it { should be_mode 755 }
end

describe file('/home/kazu634/.rbenv') do
  it { should be_owned_by 'kazu634' }
  it { should be_grouped_into 'kazu634' }
end

describe file('/home/kazu634/.rbenv/plugins') do
  it { should be_owned_by 'kazu634' }
  it { should be_grouped_into 'kazu634' }
  it { should be_mode 755 }
end

describe file('/home/kazu634/.rbenv/plugins/ruby-build') do
  it { should be_owned_by 'kazu634' }
  it { should be_grouped_into 'kazu634' }
end

describe file('/home/kazu634/.rbenv/plugins/rbenv-default-gems') do
  it { should be_owned_by 'kazu634' }
  it { should be_grouped_into 'kazu634' }
end

describe file('/home/kazu634/.rbenv/default-gems') do
  it { should be_owned_by 'kazu634' }
  it { should be_grouped_into 'kazu634' }
  it { should be_mode 644 }
end

describe file('/home/kazu634/.chef') do
  it { should be_owned_by 'kazu634' }
  it { should be_grouped_into 'kazu634' }
  it { should be_mode 775 }
end

describe file('/home/kazu634/.chef/knife.rb') do
  it { should be_owned_by 'kazu634' }
  it { should be_grouped_into 'kazu634' }
  it { should be_mode 644 }
end

describe file('/home/kazu634/.aws_setuprc') do
  it { should be_owned_by 'kazu634' }
  it { should be_grouped_into 'kazu634' }
  it { should be_mode 600 }
end
