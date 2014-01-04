name             'nagios'
maintainer       'Kazuhiro MUSASHI'
maintainer_email 'simoom634@yahoo.co.jp'
license          'All rights reserved'
description      'Installs/Configures nagios'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "build-essential"
depends "base"
depends "nginx"
depends "monit"
depends "iptables"
