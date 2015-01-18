require 'serverspec'

set :backend,  :exec

describe package('unzip') do
  it { should be_installed }
end

describe group('_serf') do
  it { should exist }
end

describe user('_serf') do
  it { should exist }
  it { should have_home_directory '/nonexistent' }
end

%w( /opt/serf /opt/serf/bin ).each do |d|
  describe file(d) do
    it { should be_directory }
    it { should be_owned_by '_serf' }
    it { should be_grouped_into '_serf' }
    it { should be_mode 755 }
  end
end

%w( /etc/serf /etc/serf/handlers ).each do |d|
  describe file(d) do
    it { should be_directory }
    it { should be_owned_by '_serf' }
    it { should be_grouped_into '_serf' }
    it { should be_mode 755 }
  end
end
