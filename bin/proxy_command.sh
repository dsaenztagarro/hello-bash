#!/bin/bash
COMMAND=$*

# Example:
# execute_command 'hello-usa' 'backend' $*
execute_command() {
  PUBLICATION=$1
  MODULE=$2

  BACKEND_DIR="/www/deploy/$PUBLICATION/backend/current"
  BACKEND_CORE_DIR="/www/deploy/$PUBLICATION/backend_core/current"
  FRONTEND_DIR="/www/deploy/$PUBLICATION/frontend/current"

  case $MODULE in
    "backend") GUEST_DIR=$BACKEND_DIR;;
    "backend_core") GUEST_DIR=$BACKEND_CORE_DIR;;
    "frontend") GUEST_DIR=$FRONTEND_DIR;;
  esac

  vagrant ssh -c "cd $GUEST_DIR; $COMMAND"
}
