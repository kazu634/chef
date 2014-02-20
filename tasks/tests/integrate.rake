#!/usr/bin/env rake

desc "Generate the test node json data."
task :test do
  require "erb"
  node_template = "nodes/template.json.erb"

  @erb = ERB.new(File.read(node_template))

  recipes = []
  recipes = traverse_cookbooks()

  File.open("nodes/sandbox.json",  "w") do |io|
    io.write @erb.result(binding)
  end


  test_template = "test/template.erb"

  @erb = ERB.new(File.read(test_template))

  tests = []
  tests = traverse_tests()

  File.open("test/Rakefile",  "w") do |io|
    io.write @erb.result(binding)
  end
end

private

def traverse_cookbooks()
  cookbooks = []

  master = `git ls-remote origin master | awk '{ print $1 }'`.chomp!
  dev = `git ls-remote origin dev | awk '{ print $1 }'`.chomp!

  cookbooks =  `git diff --stat=250,250,30 #{master} #{dev} | grep -v " \-*$" | grep site-cookbooks | sed "s/^ //" | cut -f 2 -d "/" | cut -f 1 -d "|" | sort | uniq`.split("\n")

  # Minus `base` role recipies:
  cookbooks = cookbooks - `grep recipe roles/base.json | awk -F '[\\\\[\\\\]]' '{ print $2 }'`.split("\n")

  return cookbooks
end

def traverse_tests()
  tests = []

  master = `git ls-remote origin master | awk '{ print $1 }'`.chomp!
  dev = `git ls-remote origin dev | awk '{ print $1 }'`.chomp!

  tests =  `git diff --stat=250,250,30 #{master} #{dev} | grep -v " \-*$" | grep spec | cut -f 3 -d '/' | sort | uniq`.split("\n")

  # product set between tests and `base` role recipies:
  tests = tests | ["base", "kazu634", "monit", "munin-node", "nagios-nrpe"]

  return tests
end
