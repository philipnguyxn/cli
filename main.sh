#!/bin/bash

# shellcheck source=./src/CreateSvelteTailwind/main.sh disable=SC1091
source ./src/CreateSvelteTailwind/main.sh

# shellcheck source=./src/CreateSvelteTailwind/main.sh disable=SC1091
source ./src/CreateReactTailwind/main.sh

main() {
  output_path="./temp/outputs.txt"

  tsc

  # Run the Node.js script and write the result to output.txt
  node ./dist/prompt.js

  # Read the project, name, and path from outputs.txt
  project=$(sed '1q;d' "$output_path" | sed 's/^project: //')
  name=$(sed '2q;d' "$output_path" | sed 's/^name: //')
  path=$(sed '3q;d' "$output_path" | sed 's/^path: //')

  rm -r $output_path

  case $project in
  "react")
    create_react_tailwind "$path" "$name"
    ;;
  "svelte")
    create_svelte_tailwind "$path" "$name"
    ;;
  "quit")
    exit 0
    ;;
  esac
}

main
