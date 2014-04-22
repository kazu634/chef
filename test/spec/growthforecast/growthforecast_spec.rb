require 'spec_helper'

describe file('/var/lib/growthforecast/appdata') do
  it { should be_directory }

  it { should be_owned_by 'growth' }
  it { should be_grouped_into 'growth' }

  it { should be_mode 775 }
end

describe file('/var/log/growthforecast') do
  it { should be_directory }

  it { should be_owned_by 'growth' }
  it { should be_grouped_into 'growth' }

  it { should be_mode 755 }
end

describe file('/etc/init.d/growthforecast') do
  it { should be_file }

  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }

  it { should be_mode 755 }
end

describe service('growthforecast') do
  it { should be_enabled }
  it { should be_running }
end
