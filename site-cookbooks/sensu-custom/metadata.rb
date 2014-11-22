name             'sensu-custom'
maintainer       'kazu634'
maintainer_email 'simoom634@yahoo.co.jp'
license          'All rights reserved'
description      'Installs/Configures sensu-custom'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "sensu"
depends "uchiwa"
depends "build-essential"
depends 'iptables'
depends 'nginx'
