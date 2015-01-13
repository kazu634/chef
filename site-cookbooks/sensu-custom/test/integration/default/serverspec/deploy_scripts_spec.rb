require 'serverspec'

set :backend,  :exec

scripts = %w(/etc/sensu/plugins/check-procs.rb
             /etc/sensu/plugins/check-load.rb
             /etc/sensu/plugins/check-swap.sh
             /etc/sensu/plugins/check-disk.rb
             /etc/sensu/plugins/cpu-pcnt-usage-metrics.rb
             /etc/sensu/plugins/disk-usage-metrics.rb
             /etc/sensu/plugins/load-metrics.rb
             /etc/sensu/plugins/memory-metrics.rb
             /etc/sensu/plugins/metrics-net.rb
             /etc/sensu/plugins/metrics-netstat-tcp.rb
             /etc/sensu/handlers/slack.rb
             /etc/sensu/handlers/growthforecast-handler.rb
             /etc/sensu/mutators/mutator.rb)

scripts.each do |script|
  describe file(script) do
    it { should be_owned_by 'sensu' }
    it { should be_grouped_into 'sensu' }

    it { should be_mode 755 }
  end
end
