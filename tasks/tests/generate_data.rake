#!/usr/bin/env rake

desc "Generate the test node json data."
task :gen_data do
  ## Common section ##
  require "erb"

  # Retrieve the test target cookbooks by using `git diff` command
  test_target_cookbooks = traverse_cookbooks()

  ## Generating node file section ##

  # Specify the node template file
  node_template = "nodes/template.json.erb"
  @erb          = ERB.new(File.read(node_template))

  recipes       = test_target_cookbooks

  # Generate the test node file
  File.open("nodes/sandbox.json",  "w") do |io|
    io.write @erb.result(binding)
  end

  ## Generating serverspec file section ##

  # Specify the template file section
  test_template = "test/template.erb"
  @erb          = ERB.new(File.read(test_template))

  # In the case of `serverspec` file,
  # test target cookbooks should contain `base` role cookbooks.
  # This is because, the node template file, by default,
  # contains and installs the `base` role cookbooks.
  tests       = traverse_cookbooks() | ["base",  "kazu634",  "monit",  "munin-node",  "nagios-nrpe", "fluentd-custom"]
  tests_local = traverse_cookbooks()

  File.open("test/Rakefile",  "w") do |io|
    io.write @erb.result(binding)
  end
end

private

def traverse_cookbooks()
  cookbooks = []

  master         = `git ls-remote origin master | awk '{ print $1 }'`.chomp!
  current_branch = `git rev-parse --abbrev-ref HEAD`.chomp!

  cookbooks      = `git diff --name-only #{master} #{current_branch} | grep site-cookbooks | cut -f 2 -d "/" | uniq`.split("\n")

  # Minus `base` role recipies:
  cookbooks      = cookbooks - `grep recipe roles/base.json | awk -F '[\\\\[\\\\]]' '{ print $2 }'`.split("\n")

  return cookbooks
end
