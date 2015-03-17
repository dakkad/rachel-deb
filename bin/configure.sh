#!/bin/bash


SCRIPT_PATH="${BASH_SOURCE[0]}";
source $SCRIPT_PATH/../config/sources.conf

echo "Installing dependencies."
sudo apt-get install -y reprepro s3cmd
