#!/usr/bin/env rake

desc "Download and install gems and cookbooks."
task :init do
  sh "test -e vendor || bundle install --path vendor/bundle"

  sh "test -e cookbooks || bundle exec berks vendor cookbooks"
end
