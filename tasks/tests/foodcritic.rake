#!/usr/bin/env rake

desc "Runs foodcritic linter"
task :foodcritic do
  if Gem::Version.new("1.9.2") <= Gem::Version.new(RUBY_VERSION.dup)
    sandbox = File.join(File.dirname('..'),  %w{tmp foodcritic})
    prepare_foodcritic_sandbox(sandbox)

    puts "Check the recipes:"
    sh "bundle exec foodcritic --epic-fail \"~FC048\" #{sandbox}/site-cookbooks"

    # if jsonlint exists
    if FileTest.exist?("/usr/bin/jsonlint")
      puts "Check the node json data format:"
      sh "jsonlint -v nodes/*.json"
      sh "jsonlint -v roles/*.json"
      sh "find data_bags -type f -name '*.json' | xargs -t jsonlint"
    else
      puts "No jsonlint. Skip checking the json data format."
    end

  else
    puts "WARN: foodcritic run is skipped as Ruby #{RUBY_VERSION} is < 1.9.2."
  end
end

task :default => 'foodcritic'

private

def prepare_foodcritic_sandbox(sandbox)
  rm_rf sandbox
  mkdir_p sandbox
  cp_r "site-cookbooks", sandbox
  puts "\n\n"
end
