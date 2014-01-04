#!/usr/bin/env rake

desc "Toggle ~/.ssh/config file."
task :sshconfig do
  home_dir = ENV['HOME']

  if FileTest.exist?("#{home_dir}/.ssh/config.jenkins")

    sh "mv ~/.ssh/config.jenkins ~/.ssh/config"

  else

    sh "mv ~/.ssh/config ~/.ssh/config.jenkins"

    port = `sudo docker port $(cat .docker_id) 10022 | sed -e "s/0.0.0.0://"`.chomp
    sh "sed -e 's/__PORT__/#{port}/' test/.config > ~/.ssh/config"

  end
end
