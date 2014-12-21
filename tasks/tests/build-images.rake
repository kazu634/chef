#!/usr/bin/env rake

require 'rake'

desc "Build docker images"
task :build do
  cd "docker/ubuntu1204/" do
    if File.exist?('../ubuntu1204.tar')
      sh "docker load --input ../ubuntu1204.tar"
    else
      sh "docker build -t kazu634:ubuntu1204 --rm=true --no-cache=true ."
      sh "docker save -o ../ubuntu1204.tar kazu634:ubuntu1204"
    end
  end

  cd "docker/ubuntu1404/" do
    if File.exist?('../ubuntu1404.tar')
      sh "docker load --input ../ubuntu1404.tar"
    else
      sh "docker build -t kazu634:ubuntu1404 --rm=true --no-cache=true ."
      sh "docker save -o ../ubuntu1404.tar kazu634:ubuntu1404"
    end
  end
end
