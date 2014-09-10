#!/bin/bash
PROJECT_NAME=$1
NEW_PROJECT_NAME=$2

cmd="git clone -q git@git.hola.com:/usr/local/git/$1.git $2"
eval $cmd
