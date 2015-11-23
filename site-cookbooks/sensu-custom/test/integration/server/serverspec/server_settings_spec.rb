require 'serverspec'
require 'json'

set :backend,  :exec

# `iptables` testing:
describe iptables do
  it { should have_rule('-A FWR -p tcp -m tcp --dport 4567 -j ACCEPT') }
  it { should have_rule('-A FWR -p tcp -m tcp --dport 5671 -j ACCEPT') }
  it { should have_rule('-A FWR -p tcp -m tcp --dport 6379 -j ACCEPT') }
end

%w(redis.conf rabbitmq.conf sensu-server.conf sensu-api.conf).each do |conf|
  describe file("/etc/monit/conf.d/#{conf}") do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 644 }
  end
end

describe file('/etc/nginx/sites-available/sensu') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }
end

describe file('/etc/nginx/sites-enabled/sensu') do
  it { should be_linked_to '/etc/nginx/sites-available/sensu' }
end

# Ubuntu 12.04 only.
# Check whether `Rabbitmq` allows ssl poodle attack:

platform_version = JSON.load(`ohai`)['platform_version']

if platform_version == '12.04'
  describe file('/etc/rabbitmq/rabbitmq.config') do
    its(:content) { should match /ssl_allow_poodle_attack/ }
  end
end
