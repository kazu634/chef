require 'spec_helper'

describe file('/etc/dpkg/dpkg.cfg.d/multiarch') do
  it { should be_file }
  it { should match_md5checksum '792101a3cae62c5ffc3f0adf8777a3dd' }
end

describe file('/etc/sudoers.d') do
  it { should be_directory }

  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }

  it { should be_mode 755 }
end
