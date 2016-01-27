require 'serverspec'

set :backend,  :exec

describe file('/etc/nginx/sites-available/blog') do
  it { should be_file }
  it { should be_owned_by 'root'}
  it { should be_grouped_into 'root'}
  it { should be_mode 644 }
end

describe file('/etc/nginx/sites-enabled/blog') do
  it { should be_linked_to '/etc/nginx/sites-available/blog' }
end

describe file('/var/www/blog') do
  it { should be_directory }
  it { should be_owned_by 'www-data'}
  it { should be_grouped_into 'webadm'}
  it { should be_mode 770 }
  it { should be_mounted.with( :type => 'tmpfs' ) }
end

describe file('/etc/cron.d/blog') do
  it { should be_file }
  it { should be_owned_by 'root'}
  it { should be_grouped_into 'root'}
  it { should be_mode 644 }
end

describe file('/etc/monit/conf.d/blog-log.conf') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }

  it { should be_mode 644 }
end
