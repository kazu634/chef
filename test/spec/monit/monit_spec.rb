require 'spec_helper'

describe package('monit') do
  it { should be_installed }
end

describe file('/etc/monit/monitrc') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 600 }

  it { should match_md5checksum '3b82c533d8471c12246e9b2115a2c429' }
end

describe file('/etc/init/monit.conf') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }

  it { should match_md5checksum 'b8ac9f6d996a2ebf75ada70e8a8f2ccb' }
end
