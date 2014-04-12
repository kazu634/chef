require 'spec_helper'

describe file('/etc/sensu/plugins/check-procs.rb') do
  it { should be_file }

  it { should be_owned_by 'sensu' }
  it { should be_grouped_into 'sensu' }

  it { should be_mode 755 }
end

describe file('/etc/sensu/plugins/check-log.rb') do
  it { should be_file }

  it { should be_owned_by 'sensu' }
  it { should be_grouped_into 'sensu' }

  it { should be_mode 755 }
end

describe file('/etc/sensu/plugins/check-load.rb') do
  it { should be_file }

  it { should be_owned_by 'sensu' }
  it { should be_grouped_into 'sensu' }

  it { should be_mode 755 }
end

describe file('/etc/sensu/plugins/check-swap.sh') do
  it { should be_file }

  it { should be_owned_by 'sensu' }
  it { should be_grouped_into 'sensu' }

  it { should be_mode 755 }
end

describe file('/etc/sensu/plugins/check-disk.rb') do
  it { should be_file }

  it { should be_owned_by 'sensu' }
  it { should be_grouped_into 'sensu' }

  it { should be_mode 755 }
end

describe file('/etc/sensu/handlers/tw.rb') do
  it { should be_file }

  it { should be_owned_by 'sensu' }
  it { should be_grouped_into 'sensu' }

  it { should be_mode 755 }
end
