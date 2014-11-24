require 'serverspec'

set :backend,  :exec

describe file('/var/lib/webapp/apps') do
  it { should be_directory }

  it { should be_owned_by 'webapp' }
  it { should be_grouped_into 'www-data' }

  it { should be_mode 770 }
end

describe file('/var/lib/webapp/apps/gcal2dailyplanner') do
  it { should be_directory }

  it { should be_owned_by 'webapp' }
  it { should be_grouped_into 'www-data' }
end

describe file('/var/log/gcalendar') do
  it { should be_directory }

  it { should be_owned_by 'webapp' }
  it { should be_grouped_into 'www-data' }

  it { should be_mode 755 }
end

describe file('/etc/nginx/sites-available/gcal') do
  it { should be_file }

  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }

  it { should be_mode 644 }
end

describe file('/etc/nginx/sites-enabled/gcal') do
  it { should be_linked_to '/etc/nginx/sites-available/gcal' }
end

describe service('webapp_calendar') do
  it { should be_enabled }
end

describe file('/etc/init.d/webapp_calendar') do
  it { should be_file }

  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 755 }

  its(:md5sum) { should eq '8c8dd37c77a760a572a78bcc1e5b0add' }
end

describe file('/etc/logrotate.d/gcal') do
  it { should be_file }

  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }

  its(:md5sum) { should eq 'e7483915a9ec1fec5e8c9c80952cbda0' }
end
