require 'spec_helper'

describe package('ruby') do
  it { should be_installed }
end

describe package('rubygems') do
  it { should be_installed }
end
