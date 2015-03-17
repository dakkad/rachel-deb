#!/bin/bash

RACHEL_CONTENT=https://github.com/needlestack/rachel-content.git

SCRIPT_PATH="${BASH_SOURCE[0]}";
MODULES_ROOT=$SCRIPT_PATH/../modules/

echo "Installing dependencies."
sudo apt-get install reprepro s3cmd
