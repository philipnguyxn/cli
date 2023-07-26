#!/bin/bash

# shellcheck source=./src/CreateSvelteTailwind/main.sh disable=SC1091
source ./src/CreateSvelteTailwind/main.sh

# shellcheck source=./src/CreateSvelteTailwind/main.sh disable=SC1091
source ./src/CreateReactTailwind/main.sh

main() {
  tsc

  framework=$(node ./dist/cli_prompt.js)

  # read -r -p 'What is the project'\''s name: ' project_name

  # read -r -p 'Where do you want to create the project in ' project_name

  case $framework in
  "react")
    echo "You choose react"
    # create_react_tailwind
    ;;
  "svelte")
    echo "You choose svelte"

    # create_svelte_tailwind
    ;;
  "quit")
    exit 0
    ;;
  esac
}

main
