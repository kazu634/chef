#!/usr/bin/env rake

require 'rake'

desc "Run CI tests."
task :test do
  cookbooks = `git diff --name-only master..$(git symbolic-ref HEAD) | grep site-cookbooks | grep -v wordpress | cut -f 2 -d / | awk '!a[$0]++'`

  cookbooks.split("\n").each do |cookbook|
    cookbook.strip!

    cd "site-cookbooks/#{cookbook}/" do

      sh "bundle ex kitchen verify all --concurrency=2 --destroy=always"

    end
  end
end
