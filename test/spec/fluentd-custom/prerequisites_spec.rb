require 'spec_helper'

describe file('/etc/security/limits.d/90-nfile.conf') do
  it { should be_file }

  it { should be_owned_by "root" }
  it { should be_grouped_into 'root' }

  it { should be_mode 644 }

  it { should match_md5checksum 'aec6baa602695938e5dca2bd11560442' }
end
