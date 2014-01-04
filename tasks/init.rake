#!/usr/bin/env rake

desc "Download and install gems and cookbooks."
task :init do
  sh "test -e vendor || bundle install --path vendor/bundle"

  sh "test -e cookbooks || bundle exec berks --path cookbooks"

  sh "mkdir -p site-cookbooks/openvpn-wrapper/libraries/"
  sh "cp -pr cookbooks/chef-solo-search/libraries/* site-cookbooks/openvpn-wrapper/libraries/"
end
