require 'serverspec'

set :backend,  :exec

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

  its(:md5sum) { should eq '1e356bb9d9241cafa8652394ef1d34fa' }
end

describe service('growthforecast') do
  it { should be_enabled }
  it { should be_running }
end

describe file('/etc/nginx/sites-available/growth') do
  it { should be_file }

  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }

  it { should be_mode 644 }
end

describe file('/etc/nginx/sites-enabled/growthforecast') do
  it { should be_linked_to '/etc/nginx/sites-available/growth' }
end

