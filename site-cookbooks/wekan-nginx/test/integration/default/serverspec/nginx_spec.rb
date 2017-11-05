require 'serverspec'

set :backend, :exec

describe file('/etc/nginx/sites-available/wekan-nginx') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }
end

