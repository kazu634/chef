require 'spec_helper'

describe file('/home/kazu634/.vim') do
  it { should be_directory }
end

describe file('/home/kazu634/.vim/bundle/neobundle.vim') do
  it { should be_directory }
end

