#!/usr/bin/env rake

require 'rake'

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
