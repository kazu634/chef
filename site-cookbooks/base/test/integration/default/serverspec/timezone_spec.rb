require 'serverspec'

describe file('/etc/localtime') do
  it { should be_file }

  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/etc/timezone') do
  it { should be_file }

  its(:md5sum) { should eq '5fb64d575eb1b84e443741f1fb4e5e3c' }
end
