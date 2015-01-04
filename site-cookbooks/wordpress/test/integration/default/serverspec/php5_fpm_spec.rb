require 'serverspec'

set :backend,  :exec

describe file('/etc/php5/fpm/pool.d/www.conf') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }

  it { should be_mode 644 }

  its(:md5sum) { should eq '146dc83c13d5ce9fad2107bf57ed1ba6' }
end
