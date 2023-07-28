#!/bin/bash

# shellcheck source=./src/create_svelte/main.sh disable=SC1091
source ./src/create_svelte/main.sh

# shellcheck source=./src/create_react/main.sh disable=SC1091
source ./src/create_react/main.sh

main() {
  output_path="./temp/outputs.txt"

  tsc

  # Run the Node.js script and write the result to output.txt
  node ./dist/prompt.js

  # Read the project, name, and path from outputs.txt
  project=$(sed '1q;d' "$output_path" | sed 's/^project: //')
  name=$(sed '2q;d' "$output_path" | sed 's/^name: //')
  path=$(sed '3q;d' "$output_path" | sed 's/^path: //')

  case $project in
  "react")
    create_react_tailwind "$path" "$name"
    ;;
  "svelte")
    create_svelte_project "$path" "$name"
    ;;
  "quit")
    exit 0
    ;;
  esac
}

main
