#!/usr/bin/env rake

require 'rake'

desc "Run serverspec locally."
task :localspec do
  sh "cd test && SUDO_PASSWORD=musashi bundle exec rake serverspec:test"
end

desc "Run serverspec via Jenkins"
task :serverspec do
  sh "cd test && SUDO_PASSWORD=musashi bundle exec rake ci:setup:rspec serverspec:sandbox-test"
end
