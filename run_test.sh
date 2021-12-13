#!/bin/bash

# Prepare running command
#



function prepare_railflow_docker() {
  echo -e "\n Starting railflow docker in detach mode"
  DOCKER_IMAGE=$1
  DOCKER_RAILFLOW=$(docker run -d $DOCKER_IMAGE tail -f /dev/null)
}

function exec_tests() {
  prepare_railflow_docker "railflow/railflow"

  if ! (docker exec -it $DOCKER_RAILFLOW\
    npx railflow\
    -k    $RAILFLOW_KEY\
    -url  $RAILFLOW_URL\
    -u    $RAILFLOW_USERNAME\
    -p    $RAILFLOW_PASSWORD\
    -pr   $RAILFLOW_PROJECT_NAME\
    -path $RAILFLOW_PROJECT_PATH\
    -f    $RAILFLOW_REPORT_FORMAT\
    -r    $RAILFLOW_REPORT_PATH\
    -sm   $RAILFLOW_SEARCH_MODE\
    -tp   $RAILFLOW_TEST_PLAN\
    -tr   $RAILFLOW_TEST_RUN\
    -a    $RAILFLOW_ASSIGN_FAILURE_TO) ; then
      EXIT_STATUS=1
  fi
}
