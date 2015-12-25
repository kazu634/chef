#!/usr/bin/env rake

require 'rake'
require 'parallel'

namespace :ci do
  desc 'Run CI tests.'
  task :test do
    cookbooks = `git diff --name-status master..$(git symbolic-ref HEAD) | grep site-cookbooks | grep -v ^D | grep -v wordpress | awk '{ print $2 }' | cut -f 2 -d / | awk '!colname[$1]++{print $1}'`

    if cookbooks.empty?
      puts 'No cookbooks are modified. Skip CI testing.'
      exit 0
    else
      # Delete `Berksfile.lock`:
      sh 'find `pwd`/site-cookbooks/ -type f -name "Berksfile.lock" | xargs -t rm'

      cookbooks.split("\n").each do |cookbook|
        cookbook.strip!

        cd "site-cookbooks/#{cookbook}/" do
          # if `test-kitchen` uses `Virtualbox`, skip CI testing.
          # Otherwise, do the CI testing:
          sh 'grep vagrant .kitchen.yml > /dev/null || bundle ex kitchen verify all --concurrency=2 --destroy=always'
        end
      end
    end
  end

  desc 'Build docker images'
  task :build do
    # Retrieve the list of the modified files:
    modified_files = `git diff --name-only master..\`git symbolic-ref HEAD\` | grep -v wordpress`

    # If no cookbooks are modified, exit task:
    unless modified_files.include?('site-cookbooks')
      puts 'No cookbooks are modified, so skip building the docker images.'

      exit
    end

    # building the docker images:
    %w(ubuntu1204 ubuntu1404).each do |target_env|
      # change directory to docker/ubuntuxxxx:
      cd "docker/#{target_env}/" do
        # If the modified files include "Dockerfile" and the docker image exists:
        if modified_files.include?('Dockerfile') && File.exist?("../#{target_env}.tar")
          # Delete the docker image:
          File.unlink("../#{target_env}.tar")
        end

        # If the docker image exists:
        if File.exist?("../#{target_env}.tar")
          # Load it:
          sh "docker load --input ../#{target_env}.tar"

          # otherwise build the docker image:
        else
          sh "docker build -t kazu634:#{target_env} --rm=true --no-cache=true ."
          sh "docker save -o ../#{target_env}.tar kazu634:#{target_env}"
        end
      end
    end
  end

  desc 'Destroy all the `test-kitchen` instances'
  task :destroy do
    cookbooks = `ls -1 site-cookbooks`

    cookbooks.split("\n").each do |cookbook|
      cookbook.strip!

      cd "site-cookbooks/#{cookbook}/" do
        sh 'bundle ex kitchen destroy all'
      end
    end

    sh 'docker images | grep none | awk \'{ print $3 }\' | xargs -n 1 -t docker rmi -f'
  end

  desc 'Build vagrant images'
  task :vagrant do
    cd 'images/vagrant/' do
      cmds = [
          'packer build -only=virtualbox-iso ubuntu-12.04-amd64.json',
          'packer build -only=virtualbox-iso ubuntu-14.04-amd64.json'
      ]

      Parallel.each(cmds, in_threads: 2) {|cmd|
        sh "#{cmd}"
      }
    end
  end
end
