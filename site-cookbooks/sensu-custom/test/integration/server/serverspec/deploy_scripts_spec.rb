require 'serverspec'

set :backend,  :exec

scripts = %w{ /etc/sensu/plugins/check-procs.rb
              /etc/sensu/plugins/check-log.rb
              /etc/sensu/plugins/check-load.rb
              /etc/sensu/plugins/check-swap.sh
              /etc/sensu/plugins/check-disk.rb
              /etc/sensu/handlers/tw.rb
              /etc/sensu/handlers/hipchat.rb }

scripts.each do |script|
  describe file(script) do
    it { should be_owned_by 'sensu' }
    it { should be_grouped_into 'sensu' }

    it { should be_mode 755 }
  end
end
