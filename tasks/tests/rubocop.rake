#!/usr/bin/env rake

namespace :rubocop do
  desc 'Runs rubocop linter during CI testing'
  task :test do
    if Gem::Version.new('1.9.2') <= Gem::Version.new(RUBY_VERSION.dup)

      # retrieve the list of the modified cookbooks:
      modified_recipes =
        `git diff --name-status master..$(git symbolic-ref HEAD) | egrep -v "(^D|\.erb|metadata\.rb)" | grep ".rb" | awk '{ print $2 }'`

      # if no cookbooks are modified, skip `rubocop`.
      if modified_recipes.empty?
        puts 'No cookbooks are modified, so skip `rubocop` check.'
      else
        # Running `rubocop` test:
        puts 'Check the Ruby source:'

        modified_recipes.split.each do |recipe|
          sh "bundle exec rubocop -F #{recipe}"
        end
      end

    else
      puts 'WARN: `Rubocop` run is skipped as Ruby #{RUBY_VERSION} is < 1.9.2.'
    end
  end

  desc 'Check whole Ruby source codes.'
  task :check do
    if Gem::Version.new('1.9.2') <= Gem::Version.new(RUBY_VERSION.dup)
      sh 'bundle exec rubocop -F'
    else
      puts 'WARN: `Rubocop` run is skipped as Ruby #{RUBY_VERSION} is < 1.9.2.'
    end
  end

  desc 'Correct the single Ruby source code'
  task :correct do
    if Gem::Version.new('1.9.2') <= Gem::Version.new(RUBY_VERSION.dup)
      sh 'bundle exec rubocop --format files | head -1 | xargs bundle ex rubocop -a'
      sh 'git diff'
    else
      puts 'WARN: `Rubocop` run is skipped as Ruby #{RUBY_VERSION} is < 1.9.2.'
    end
  end
end
