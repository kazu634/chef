require 'serverspec'

set :backend,  :exec

describe file('/etc/mysql/my.cnf') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }

  it { should be_mode 644 }

  its(:md5sum) { should eq '09590048fcd1824f2db674c0831a701a' }
end

describe service('mysql') do
  it { should be_enabled }
  it { should be_running }
end

describe command('mysql -uroot -p123qweASD -e "show databases;" | grep blog') do
  its(:exit_status) { should eq 0 }
end

describe command('mysql -uroot -p123qweASD -e "show grants for \'wp-db-admin\'@\'localhost\';"  | grep blog') do
  its(:exit_status) { should eq 0 }
end
