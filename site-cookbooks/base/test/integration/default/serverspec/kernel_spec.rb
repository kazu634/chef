require 'serverspec'

describe file('/etc/sysctl.d/90-vm-swappiness.conf') do
  it { should be_file }

  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }

  it { should be_mode 644 }

  its(:content) { should match /vm.swappiness = 10/ }
end

describe file('/etc/sysctl.d/90-vfs-cache-pressure.conf') do
  it { should be_file }

  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }

  it { should be_mode 644 }

  its(:content) { should match /vm.vfs_cache_pressure = 50/ }
end
