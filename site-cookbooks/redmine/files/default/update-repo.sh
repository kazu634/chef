#!/bin/bash

set -e

REPOS=$(find $(pwd) -maxdepth 1 -mindepth 1 -type d)

for repo in ${REPOS}; do
  cd ${repo} && git fetch > /dev/null
done
