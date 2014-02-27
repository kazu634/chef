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

## How to install chef, its libraries, and official cookbooks
Execute the following commands:

    gem install bundler --no-ri --no-rdoc

    rbenv rehash

    bundle exec rake init

That's it. Easy enough?

## How to Get the Encrypted Databag Secret Key
You know the secret key is on /home/kazu634.
Just copy the key to /path/to/chef.

## How to manipulate an encrypted data bag
This section illustrate how to manipulate an encrypted data bag

### How to make an encrypted data bag

    export EDITOR="vim -u NONE -U NONE --noplugin"

    bundle exec knife solo data bag create apps app_1

### How to show an encrypted data bag

    export EDITOR="vim -u NONE -U NONE --noplugin"

    bundle exec knife solo data bag show apps app_1

### How to edit an encrypted data bag

    export EDITOR="vim -u NONE -U NONE --noplugin"

    bundle exec knife solo data bag edit apps app_1

# Build Status
[![Build Status](https://api.travis-ci.org/kazu634/chef.png)](https://api.travis-ci.org/kazu634/chef.png)
