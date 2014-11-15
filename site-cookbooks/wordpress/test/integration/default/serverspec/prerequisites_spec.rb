require 'serverspec'

set :backend,  :exec

pre_requisites = %w{php5-common php5-cgi php5-cli php5-mysql php5-gd php5-fpm mysql-server}

pre_requisites.each do |p|
  describe package(p) do
    it { should be_installed }
  end
end
