name             'fluentd-custom'
maintainer       'Kazuhiro MUSASHI'
maintainer_email 'simoom634@yahoo.co.jp'
license          'All rights reserved'
description      'Installs/Configures fluentd-custom'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "chef-td-agent"
depends "monit"