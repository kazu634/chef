# How to install chef
The procedure consists of 2 parts:

- How to install rbenv
- How to install chef

## How to install rbenv
Execute the following commands. See also: https://github.com/sstephenson/rbenv/

    # switch the user you want to install and use chef
    su - kazu634

    # install prerequisites
    aptitude install libreadline-dev libssl-dev zlib1g-dev libssl1.0.0

    # git clone rbenv
    git clone git://github.com/sstephenson/rbenv.git ~/.rbenv

    # git clone ruby-build
    git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

    # Reload the shell
    exec $SHELL -l

    # install
    rbenv install xxxxxxx

    rbenv global xxxxxxx

    rbenv rehash

## How to install chef
Execute the following commands:

    gem install bundler --no-ri --no-rdoc

    rbenv rehash

    bundle --path vendor/bundle

## How to Download & Install 3rd Party Cookbooks
Execute the following commands:

    bundle exec berks --path cookbooks

That's it. Easy enough?

## How to Get the Encrypted Databag Secret Key
You know the secret key is on /home/kazu634.
Just copy the key to /path/to/chef.

# Build Status
[![Build Status](https://api.travis-ci.org/kazu634/chef.png)](https://api.travis-ci.org/kazu634/chef.png)
