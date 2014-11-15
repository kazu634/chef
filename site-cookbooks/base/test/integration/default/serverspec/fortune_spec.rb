require 'serverspec'

describe package('fortune-mod') do
  it { should be_installed }
end

describe file('/usr/share/games/fortunes/starwars.dat') do
  it { should be_file }

  it { should be_readable }

  its(:md5sum) { should eq 'a3d1b7f6441537101d3b76b66e70c510'}
end
