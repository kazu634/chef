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

  it { should match_md5checksum '3064b7026d75fc33bca1a8675beed0d5' }
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

  it { should match_md5checksum '163657859bd82223b8f7f5827b0b947a' }
end

describe file('/etc/nginx/sites-enabled/growthforecast') do
  it { should be_linked_to '/etc/nginx/sites-available/growth' }
end

