#!/usr/bin/env rake

desc "Runs chefspec tests"
task :chefspec do
  sh 'find `pwd`/site-cookbooks -type f -name "*_spec.rb" | xargs bundle exec rspec'
end
