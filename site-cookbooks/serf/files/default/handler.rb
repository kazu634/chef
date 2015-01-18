#!/opt/chef/embedded/bin/ruby

require 'slack-notify'

client = SlackNotify::Client.new(
  webhook_url: 'https://hooks.slack.com/services/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',
  channel: '#ops',
  username: 'kazu-chan',
  icon_url: 'http://sensuapp.org/img/sensu_logo_large-c92d73db.png',
  link_names: 1
)

host, _ipadr, _others = STDIN.gets.split(/\s/)

case ENV['SERF_EVENT']
when 'member-join'
  client.notify("`#{host}` is booting up.")

when 'member-failed'
  client.notify("`#{host}` isn't working properly.")

when 'member-leave'
  system("curl -s -X DELETE http://localhost:4567/clients/#{host}")

  client.notify("`#{host}` is shutting down.")

when 'member-reap'
  require 'growthforecast'

  gf = GrowthForecast.new('localhost',  5125)

  gf.graphs.each do |graph|
    gf.delete(graph) if /#{host}/ =~ graph.service_name
  end

  client.notify("Delete #{host}'s graphs.")

else
  exit
end
