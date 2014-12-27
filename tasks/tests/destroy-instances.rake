#!/usr/bin/env rake

require 'rake'

desc "Destroy all the `test-kitchen` instances"
task :destroy do
  cookbooks = `ls -1 site-cookbooks`

  cookbooks.split("\n").each do |cookbook|
    cookbook.strip!

    cd "site-cookbooks/#{cookbook}/" do

      sh "bundle ex kitchen destroy all"

    end
  end

  sh 'docker images | grep none | awk \'{ print $3 }\' | xargs -n 1 -t docker rmi -f'
end
