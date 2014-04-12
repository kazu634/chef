require 'spec_helper'

describe package('nagios-plugins') do
  it { should be_installed }
end
