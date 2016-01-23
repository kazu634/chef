require 'serverspec'

set :backend,  :exec

%w( body fastcgi proxy scgi uwsgi ).each do |d|
  describe file("/var/lib/nginx/#{d}") do
    it { should be_owned_by 'www-data' }
    it { should be_grouped_into 'root' }
    it { should be_mode 755 }
  end
end

%w( sites-available sites-enabled ).each do |d|
  describe file("/etc/nginx/#{d}") do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 755 }
  end
end

describe file('/etc/nginx/nginx.conf') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }
end

describe file('/etc/nginx/sites-available/default') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }
end

describe file('/etc/nginx/sites-enabled/default') do
  it { should be_linked_to '/etc/nginx/sites-available/default' }
end

describe file('/etc/logrotate.d/nginx') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }
end

describe iptables do
  it { should have_rule('-A FWR -p tcp -m tcp --dport 80 -j ACCEPT') }
  it { should have_rule('-A FWR -p tcp -m tcp --dport 443 -j ACCEPT') }
end
