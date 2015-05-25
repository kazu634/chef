require 'serverspec'

set :backend,  :exec

describe file('/etc/nginx/conf.d/wordpress_proxy.conf') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }

  it { should be_mode 644 }

  its(:md5sum) { should eq '0da65c226e2b4417fc994782c9d24087' }
end

describe file('/etc/nginx/sites-available/wordpress') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }

  it { should be_mode 644 }
end

describe file('/etc/nginx/sites-enabled/wordpress') do
  it { should be_linked_to '/etc/nginx/sites-available/wordpress' }
end

describe file('/etc/monit/conf.d/wordpress-log.conf') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }

  it { should be_mode 644 }
end
