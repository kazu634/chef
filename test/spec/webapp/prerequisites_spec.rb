require 'spec_helper'

describe user('webapp') do
  it { should exist }
  it { should have_home_directory '/var/lib/webapp' }
  it { should have_login_shell '/bin/bash' }
end

describe file('/var/lib/webapp/.rbenv/shims/ruby') do
  it { should be_file }
end
