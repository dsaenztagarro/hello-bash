#!/bin/bash
PROJECT_NAME=$1

cmd="git clone -q git@git.hola.com:/usr/local/git/chef_$1_cookbook.git"
eval $cmd
