require 'spec_helper'

describe file('/var/lib/growthforecast/perl5/perlbrew/bin/perlbrew') do
  it { should be_file }
end

describe file('/var/lib/growthforecast/.bashrc') do
  it { should be_file }

  it { should contain 'perlbrew/etc/bashrc' }
end

describe file('/var/lib/growthforecast/perl5/perlbrew/bin/cpanm') do
  it { should be_file }
end
