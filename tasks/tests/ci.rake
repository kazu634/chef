#!/usr/bin/env rake

require 'rake'

desc 'Run CI tests.'
task :test do
  cookbooks = `git diff --name-status master..$(git symbolic-ref HEAD) | grep site-cookbooks | grep -v ^D | grep -v wordpress | awk '{ print $2 }' | cut -f 2 -d /`

  if cookbooks.empty?
    puts 'No cookbooks are modified. Skip CI testing.'
    exit 0
  else
    cookbooks.split("\n").each do |cookbook|
      cookbook.strip!

      cd "site-cookbooks/#{cookbook}/" do
        sh 'bundle ex kitchen verify all --concurrency=2 --destroy=always'
      end
    end
  end
end
