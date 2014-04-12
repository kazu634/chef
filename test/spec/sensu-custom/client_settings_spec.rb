require 'spec_helper'

describe file('/etc/sudoers.d/sensu') do
  it { should be_file }

  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }

  it { should be_mode 440 }
end
