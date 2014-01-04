require 'spec_helper'

describe file('/etc/default/ntpdate') do
  it { should be_file }

  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }

  it { should be_mode 644 }

  it { should match_md5checksum '575e65509735f9e9cb3aa260cfcd78e4' }
end

describe file('/etc/cron.hourly/ntpdate') do
  it { should be_file }

  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }

  it { should be_mode 755 }

  it { should match_md5checksum '8a9e1717e991670f067305ac5ff22231' }
end
