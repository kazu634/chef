require 'serverspec'

set :backend,  :exec

case os[:release].to_f
when 16.04
  describe file('/lib/systemd/system/nginx.service') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 644 }

    its(:md5sum) { should eq 'd4f2385a8880937d3aea659c82832989' }
  end
else
  describe file('/etc/monit/conf.d/nginx.conf') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 644 }

    its(:md5sum) { should eq '4d7f0276e7efea61d687a2886cfa5569' }
  end
end
